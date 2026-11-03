"""Last bounded REA targets: JSON configuration and original QueryMap control flow."""
from pathlib import Path
import json,re,zipfile
from dex_evidence import Dex,APK
A=Path(__file__).resolve().parent
all_methods=[];dexes=[]
with zipfile.ZipFile(APK) as z:
 for n in z.namelist():
  if re.fullmatch(r'classes\d*\.dex',n):
   d=Dex(z.read(n),n);dexes.append(d);all_methods.extend((d,m) for m in d.defined)
selected={'Lhj5;':{'<clinit>'},'Ltt3;':{'e','p'},'Lqj4;':{'f'}}
for d,m in all_methods:
 if m['class']=='Lhj5;' and m['name']=='<clinit>':
  instructions=d.instructions(m);print('JSON config original calls',[i.get('method') for i in instructions if 'method' in i]);print('JSON config types',[i.get('type') for i in instructions if 'type' in i]);print('JSON config consts',[(hex(i['pc']),i.get('literal'),i.get('string')) for i in instructions if 'literal' in i or 'string' in i])
  for i in instructions:
   if i.get('type','').startswith('L') and i['type'] in {m['class'] for d,m in all_methods}:
    selected.setdefault(i['type'],set()).update({'invoke','<init>'})
tasks=[];raw=[]
for d,m in all_methods:
 if m['class'] in selected and m['name'] in selected[m['class']]:
  cls=m['class'][1:-1].replace('/','.');tasks.append({'id':f'{len(tasks):03d}-final-'+re.sub(r'[^\w.-]','_',cls+'-'+m['name']),'operation':'inspect_android_method','class_name':cls,'method_name':m['name'],'dex_descriptor':m['prototype'],'original_method_id':m['id']})
 if (m['class']=='Lcom/picacg/domain/model/ComicListParams;' and m['name']=='toQueryMap') or (m['class']=='Lat1;' and m['name']=='c') or (m['class']=='Lnh4;' and m['name']=='d') or (m['class']=='Lhj5;' and m['name']=='<clinit>'):
  raw.append({'dex':d.name,'method':m,'instructions':d.instructions(m)})
(A/'rea_final_batch.json').write_text(json.dumps({'output_directory':'analysis/rea/final','scope':'JSON config/defaults and descriptor optional flags','tasks':tasks},ensure_ascii=False,indent=2),encoding='utf8')
(A/'rea_original_corrections.json').write_text(json.dumps(raw,ensure_ascii=False,indent=2),encoding='utf8')
print('Final tasks',len(tasks),[(t['class_name'],t['method_name']) for t in tasks])
