// Project-local batch adapter over REA 6.8.0's same AndroidAnalysisService used by CLI.
// Real REA+JADX execution, never runs target APK. No changes to REA or global config.
import { readFile, writeFile, mkdir } from 'node:fs/promises';
import { dirname, resolve, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { createAndroidAnalysisProvider } from '../.rea-tools/node_modules/rea-agents/dist/composition/android.js';
import { AndroidAnalysisService } from '../.rea-tools/node_modules/rea-agents/dist/application/android/AndroidAnalysisService.js';
const root=resolve(dirname(fileURLToPath(import.meta.url)),'..');
const manifest=JSON.parse(await readFile(join(root,'.rea-tools/download-manifest.json'),'utf8'));
// Keep both Node's owned workspace parent and JADX's JVM scratch files inside this project.
const temp=join(root,'.rea-tools/runtime-temp');await mkdir(temp,{recursive:true});
process.env.TEMP=temp;process.env.TMP=temp;
const env={...process.env,JAVA_HOME:manifest.JAVA_HOME,REA_JADX_MCP_JAR:join(root,'.rea-tools/jadx-headless-mcp-0.7.1-all.jar'),REA_JADX_HEAP_MIB:'2048',REA_JADX_ACTIVE_PROCESSOR_COUNT:'2',REA_JADX_OPERATION_TIMEOUT_MS:'600000',JAVA_TOOL_OPTIONS:[process.env.JAVA_TOOL_OPTIONS,`-Djava.io.tmpdir=${temp}`].filter(Boolean).join(' ')};
const provider=createAndroidAnalysisProvider(env);
const service=new AndroidAnalysisService(provider);
const batchFile=resolve(process.argv[2]);
const batch=JSON.parse(await readFile(batchFile,'utf8'));
// PICA_ROOT / PICA_APK let the same batch file run against another version and another output root.
const base=process.env.PICA_ROOT?resolve(process.env.PICA_ROOT):root;
const out=resolve(base,batch.output_directory);
await mkdir(out,{recursive:true});
const apk=process.env.PICA_APK?resolve(process.env.PICA_APK):join(base,'picacg-v2.6.73.apk');
const summaries=new Map();const index=[];
const serializeError=e=>({name:e?.name,message:e?.message,code:e?.code,diagnostics:e?.diagnostics,details:e?.details,issues:e?.issues,cause:e?.cause?serializeError(e.cause):undefined});
const skipped=[];let currentTask;
async function call(id,operation,input){
  const start=Date.now();const result=await service.execute(operation,{path:apk,...input});
  const saved=result.ok?result.value:{ok:false,error:serializeError(result.error)};
  const file=join(out,id+'.json');await writeFile(file,JSON.stringify(saved,null,2),'utf8');
  const item={id,operation,input,ok:result.ok,file,elapsed_ms:Date.now()-start};
  if(result.ok){const n=result.value.normalized_result;item.evidence_id=result.value.evidence_id;item.representation=n.representation;item.body_status=n.body_status;item.source_status=n.source?.status;if(n.source?.text){item.source_file=join(out,id+'.'+(n.representation==='smali'?'smali':'java'));await writeFile(item.source_file,n.source.text,'utf8');}}
  else item.error=serializeError(result.error);
  if(currentTask) item.original_task=currentTask;
  index.push(item);console.log(JSON.stringify(item));
  await writeFile(join(out,'index.json'),JSON.stringify(index,null,2),'utf8');
  if(!result.ok && /spawn EPERM/.test(JSON.stringify(saved))) throw new Error('Sandbox process boundary: stop after first spawn EPERM; exact command requires approval');
  return result;
}
async function summary(cls){
 if(!summaries.has(cls)) summaries.set(cls,await call('class-'+cls.replace(/[^\w.-]/g,'_'),'inspect_android_class',{class_name:cls}));
 return summaries.get(cls);
}
try{
 const ready=await provider.inspectAvailability();await writeFile(join(out,'availability.json'),JSON.stringify(ready,null,2));console.log(JSON.stringify({availability:ready}));
 if(ready.status!=='available') throw new Error('REA Android prerequisites unavailable');
 for(const task of batch.tasks){
  currentTask=task;
  if(task.operation==='inspect_android_method'||task.operation==='trace_android_references'){
   const s=await summary(task.class_name);if(!s.ok) continue;
   const ms=s.value.normalized_result.methods;
   if(task.method_name){
    const named=ms.filter(m=>m.name===task.method_name);
    let match=named.filter(m=>!task.dex_descriptor || m.dex_descriptor===task.dex_descriptor);
    // Provider descriptors can contain JADX aliases. Only accept a same-name unique
    // method fallback; never pick an ambiguous overload or pretend raw descriptors match.
    if(match.length===0 && named.length===1){match=named;task.selection_note='Unique same-name method; provider descriptor differs from original DEX (aliases possible)';}
    if(match.length!==1){const skip={id:task.id,reason:'Expected unique method identity',task,matches:named};skipped.push(skip);console.log(JSON.stringify({skipped:skip}));await writeFile(join(out,'skipped.json'),JSON.stringify(skipped,null,2),'utf8');continue;}
    await call(task.id,task.operation,{class_name:task.class_name,method_name:task.method_name,overload_index:match[0].overload_index});
   }else await call(task.id,task.operation,{class_name:task.class_name});
  }else if(task.operation==='inspect_android_class') await summary(task.class_name);
  else await call(task.id,task.operation,task.input??{});
 }
} finally {
 await provider.close();console.log('REA_PROVIDER_CLOSED');
}
