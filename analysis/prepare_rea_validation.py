"""Create exact-ID REA tasks from the frozen original-DEX manifest. No engine or target execution."""
import json,re
from pathlib import Path
root=Path(__file__).resolve().parents[1]
targets=json.loads((root/'analysis/remaining_targets.json').read_text(encoding='utf8'))
tasks=[];seen=set()
def add(mid,prefix):
    if mid in seen: return
    seen.add(mid)
    cls,methdesc=mid.split('->',1); meth,desc=methdesc.split('(',1)
    cls=cls[1:-1].replace('/','.')
    slug=re.sub(r'[^A-Za-z0-9._-]','_',prefix+'-'+cls+'-'+meth)
    tasks.append(dict(id=f'{len(tasks):03d}-{slug}',operation='inspect_android_method',class_name=cls,method_name=meth,dex_descriptor='('+desc,original_method_id=mid))
for row in targets['high_priority_exact_methods']: add(row['id'],'priority')
for group in targets['network_targets']:
    for m in group.get('methods',[]): add(m['id'],'network')
for ep in targets['pica_endpoints']:
    add(ep['id'],'api')
for group in targets['dto_targets']:
    for m in group.get('methods',[]): add(m['id'],'dto')
    for sub in ('serializer','companion'):
        for m in (group.get(sub) or {}).get('methods',[]): add(m['id'],sub)
# Nested model schemas: descriptor declarations + children suffice for wire keys/types;
# constructors kept for nullable/required defaults, without assuming every inventoried model reachable.
for group in targets.get('nested_pica_model_targets',[]):
    for m in group.get('serializer_methods',[]):
        if any(x in m['id'] for x in ('<clinit>','childSerializers','getDescriptor')): add(m['id'],'nested')
    for m in group.get('constructor_methods',[]): add(m['id'],'nested-ctor')
p=root/'analysis/rea_validation_batch.json'
p.write_text(json.dumps({'output_directory':'analysis/rea/validation','scope':'Actual REA static evidence; target not executed; exact descriptors from frozen DEX manifest','tasks':tasks},ensure_ascii=False,indent=2),encoding='utf8')
print('TASKS',len(tasks),'unique classes',len(set(t['class_name'] for t in tasks)))
