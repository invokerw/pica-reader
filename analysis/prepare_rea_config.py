"""Bounded JSON configuration and inherited encoder defaults checks."""
from pathlib import Path
import json,re,zipfile,struct
from dex_evidence import Dex,APK
A=Path(__file__).resolve().parent; pairs=[];supers={}
with zipfile.ZipFile(APK) as z:
 for n in z.namelist():
  if not re.fullmatch(r'classes\d*\.dex',n):continue
  d=Dex(z.read(n),n);pairs.extend((d,m) for m in d.defined)
  count,off=struct.unpack_from('<II',d.d,96)
  for k in range(count):
   cls,flags,superid=struct.unpack_from('<III',d.d,off+32*k)
   supers[d.types[cls]]=None if superid==0xffffffff else d.types[superid]
selected={'Lg83;':{'<init>'},'Lfs2;':{'d'}}
p='Ltt3;'
while p:
 selected.setdefault(p,set()).add('e');p=supers.get(p)
for d,m in pairs:
 if m['name']=='toString' and any('encodeDefaults=' in i.get('string','') for i in d.instructions(m)):
  print('CONFIG class',m['class']);selected.setdefault(m['class'],set()).update({'<init>','toString'})
tasks=[]
for d,m in pairs:
 if m['class'] not in selected or m['name'] not in selected[m['class']]:continue
 cls=m['class'][1:-1].replace('/','.');tasks.append({'id':f'{len(tasks):03d}-config-'+re.sub(r'[^\w.-]','_',cls+'-'+m['name']),'operation':'inspect_android_method','class_name':cls,'method_name':m['name'],'dex_descriptor':m['prototype'],'original_method_id':m['id']})
(A/'rea_config_batch.json').write_text(json.dumps({'output_directory':'analysis/rea/config','scope':'Actual PICA shared JSON config/defaults; no target execution','tasks':tasks},ensure_ascii=False,indent=2),encoding='utf8')
print('Config tasks',len(tasks),[(t['class_name'],t['method_name']) for t in tasks]);print('g83 super',supers.get('Lg83;'),'tt3 super',supers.get('Ltt3;'))
