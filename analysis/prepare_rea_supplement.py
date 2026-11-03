"""Exact-ID supplemental REA task selection from original DEX; no target execution."""
from pathlib import Path
import json,re,zipfile
from dex_evidence import Dex,APK
root=Path(__file__).resolve().parents[1]
classes={'Ls42;','Ldo0;','Lc31;','Lkx5;','Lrx5;','Llx2;','Lsx;','Lkx3;','Lys2;','Lk30;','Lzx;','Lnr0;','Ldz0;','Lai;','Lsl0;','Lqy2;','Ldh4;','Ll54;','Ldg4;','Lag4;'}
names={'Lc31;':{'n','x'},'Lkx5;':{'A0','Q0','O0'},'Lrx5;':{'d0','f0'},'Llx2;':{'b','d','g'},'Lsx;':{'i0'},'Lkx3;':{'<init>','invoke'},'Lk30;':{'<init>','q','s'},'Lzx;':{'<init>','k','toString'},'Lnr0;':{'J0'},'Ldz0;':{'invoke'},'Lai;':{'<init>','emit'},'Ldg4;':{'c'},'Lag4;':{'invokeSuspend'}}
x=json.loads((root/'analysis/remaining_targets.json').read_text(encoding='utf8'))
nested={g['class'] for g in x['nested_pica_model_targets']} if x['nested_pica_model_targets'] and 'class' in x['nested_pica_model_targets'][0] else set()
# Read frozen class key without assuming its spelling.
for g in x['nested_pica_model_targets']:
    for value in g.values():
        if isinstance(value,str) and value.startswith('Lcom/picacg/network/pica/model/') and value.endswith(';') and '$' not in value: nested.add(value)
tasks=[]; found=[]; raw=[]
with zipfile.ZipFile(APK) as z:
    for n in z.namelist():
        if not re.fullmatch(r'classes\d*\.dex',n):continue
        d=Dex(z.read(n),n)
        for m in d.defined:
            c=m['class']; name=m['name']
            choose=(c in classes and (c not in names or name in names[c]))
            choose |= c.startswith('Lcom/picacg/domain/model/') and any(w in c for w in ('RequestMode','ResolveStrategy','Subdomain'))
            choose |= c in nested and name=='<init>'
            if choose:
                cls=c[1:-1].replace('/','.');desc=m['id'].split('->',1)[1][len(name):]
                slug=re.sub(r'[^A-Za-z0-9._-]','_',cls+'-'+name)
                tasks.append(dict(id=f'{len(tasks):03d}-supp-{slug}',operation='inspect_android_method',class_name=cls,method_name=name,dex_descriptor=desc,original_method_id=m['id']))
                found.append(m['id'])
            if (c=='Lat1;' and name=='c') or (c=='Ldg4;' and name in {'c','d'}) or (c=='Lmx4;' and name=='invokeSuspend'):
                raw.append({**m,'instructions':d.instructions(m)})
(root/'analysis/rea_supplement_batch.json').write_text(json.dumps({'output_directory':'analysis/rea/supplement','scope':'REA supplemental helper, TLS defaults, nested constructor static verification','tasks':tasks},ensure_ascii=False,indent=2),encoding='utf8')
(root/'analysis/supplement_original_dex.json').write_text(json.dumps(raw,ensure_ascii=False,indent=2),encoding='utf8')
print('Supplement tasks',len(tasks),'nested',len(nested),'classes',len({t['class_name'] for t in tasks}))
print('Network named classes',[c for c in sorted({t['class_name'] for t in tasks}) if any(w in c for w in ('RequestMode','ResolveStrategy','Subdomain'))])
