"""Select small exact REA helper checks; never executes APK."""
from pathlib import Path
import json,re,zipfile,collections
from dex_evidence import Dex,APK
A=Path(__file__).resolve().parent
selected={'Lb44;':{'<init>','getDescriptor','deserialize','serialize'},'Lqj4;':{'j'},'Luo3;':{'M'},'Lix5;':{'<init>','getDescriptor','deserialize','serialize'},'Le53;':{'<init>','getDescriptor'},'Lh54;':None,'Lpr2;':{'m'},'Lsq2;':{'x'},'Lnr0;':{'J0'}}
tasks=[];dumps=[]
with zipfile.ZipFile(APK) as z:
 for n in z.namelist():
  if not re.fullmatch(r'classes\d*\.dex',n):continue
  d=Dex(z.read(n),n)
  for m in d.defined:
   if m['class'] in selected and (selected[m['class']] is None or m['name'] in selected[m['class']]):
    cls=m['class'][1:-1].replace('/','.');name=m['name'];tasks.append({'id':f'{len(tasks):03d}-closure-'+re.sub(r'[^\w.-]','_',cls+'-'+name),'operation':'inspect_android_method','class_name':cls,'method_name':name,'dex_descriptor':m['prototype'],'original_method_id':m['id']})
    if m['class']=='Luo3;':dumps+=d.instructions(m)
(A/'rea_closure_batch.json').write_text(json.dumps({'output_directory':'analysis/rea/closure','scope':'Serialization and standard TLS helper closure','tasks':tasks},ensure_ascii=False,indent=2),encoding='utf8')
print('Closure methods',len(tasks));print('Nullable wrapper referenced methods',[i['method'] for i in dumps if 'method' in i]);print('Nullable wrapper types',[i['type'] for i in dumps if 'type' in i])
for name in ('core','validation','supplement'):
 index=json.loads((A/'rea'/name/'index.json').read_text(encoding='utf8'));methods=[i for i in index if i['operation']=='inspect_android_method'];print(name,len(index),'methods',len(methods),'reps',dict(collections.Counter(i.get('representation') for i in methods)),'fail',sum(not i['ok'] for i in index),'notes',sum(bool(i.get('original_task',{}).get('selection_note')) for i in index))
