"""Final bounded default JSON and concrete encoder methods for null/default behavior."""
from pathlib import Path
import json,re,zipfile
from dex_evidence import Dex,APK
A=Path(__file__).resolve().parent;pairs=[]
with zipfile.ZipFile(APK) as z:
 for n in z.namelist():
  if re.fullmatch(r'classes\d*\.dex',n):
   d=Dex(z.read(n),n);pairs.extend((d,m) for m in d.defined)
selected={'Lb83;':{'<clinit>'},'La83;':{'<init>'}}
# Locate concrete encode-default hook implementations by their exact inherited signature.
for d,m in pairs:
 if m['name']=='e' and m['prototype']=='(Lzi5;)Z':
  instructions=d.instructions(m)
  if any('Li83;->' in i.get('field','') for i in instructions) or m['class'] in {'Lcx5;','Lsx5;','Lwx5;'}:
   selected.setdefault(m['class'],set()).update({'e','d'})
print('Selected concrete encoders',selected)
tasks=[]
for d,m in pairs:
 if m['class'] not in selected or m['name'] not in selected[m['class']]:continue
 cls=m['class'][1:-1].replace('/','.');tasks.append({'id':f'{len(tasks):03d}-defaults-'+re.sub(r'[^\w.-]','_',cls+'-'+m['name']),'operation':'inspect_android_method','class_name':cls,'method_name':m['name'],'dex_descriptor':m['prototype'],'original_method_id':m['id']})
(A/'rea_defaults_batch.json').write_text(json.dumps({'output_directory':'analysis/rea/defaults','tasks':tasks},ensure_ascii=False,indent=2),encoding='utf8')
print('Default methods',len(tasks))
