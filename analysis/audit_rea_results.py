"""Read-only checks of saved actual REA outputs + deliverable links; writes audit summary.
No target execution or network requests. Counts are request results, not unique methods.
"""
from pathlib import Path
import json,hashlib,re,collections,urllib.parse
from paths import APK, OUT as A, sha256
ROOT=Path(__file__).resolve().parents[1]
sha=sha256()
jarsha=hashlib.sha256((ROOT/'.rea-tools/jadx-headless-mcp-0.7.1-all.jar').read_bytes()).hexdigest()
expected_apk='68b1a02d634f791a673bd58935208cde8c896a6ea0912fcbf1b946d9a229c06e'
assert sha==expected_apk, f'本审计脚本只针对 2.6.73 的存档批次，当前样本 SHA256 是 {sha}'
batches=[];ids=set();digests=set();total=collections.Counter();exact=0
for name in ('core','validation','supplement','closure','final','config','defaults'):
 items=json.loads((A/'rea'/name/'index.json').read_text(encoding='utf8'));counts=collections.Counter();notes=0
 for i in items:
  assert i['ok'], (name,i)
  file=Path(i['file']);assert file.is_file(),file
  e=json.loads(file.read_text(encoding='utf8'))
  assert e['evidence_id']==i['evidence_id']
  assert e['subject']['digest']['sha256']==sha
  assert e['raw_result']['jar_sha256']==jarsha
  digests.add(e['raw_result']['bridge_sha256'])
  counts['operations']+=1;counts[i['operation']]+=1
  if i.get('source_file'):
   source=Path(i['source_file']);assert source.read_bytes().decode('utf8')==e['normalized_result']['source']['text'], (name,i['id'],'saved source differs')
  if i['operation']=='inspect_android_method':
   counts[i['representation']]+=1
   t=i.get('original_task',{});notes+=bool(t.get('selection_note'))
   if t.get('dex_descriptor'):
    assert e['normalized_result']['method']['dex_descriptor']==t['dex_descriptor'],(name,i['id'])
    assert e['normalized_result']['method']['name']==t['method_name']
    exact+=1;ids.add(t['original_method_id'])
  assert not i.get('error')
 assert notes==0
 batch=json.loads((A/f'rea_{name}_batch.json').read_text(encoding='utf8'))
 requested={t['id'] for t in batch['tasks'] if t['operation']!='inspect_android_class'}
 completed={i['id'] for i in items}
 assert requested<=completed, (name,requested-completed)
 total.update(counts);batches.append({'batch':name,**dict(counts),'failures':0,'selection_notes':notes})
assert len(digests)==1
model=json.loads((A/'rea_model_schema.json').read_text(encoding='utf8'))
assert model['model_count']==len(model['models'])==62
assert model['wire_field_count']==sum(len(m['wire_fields']) for m in model['models'])==299
report={'apk_sha256':sha,'jar_sha256':jarsha,'bridge_sha256':next(iter(digests)), 'batches':batches,'total':dict(total),'exact_method_requests':exact,'unique_exact_method_ids':len(ids),'model_count':62,'wire_field_count':299,'scope':'Saved successful REA operations only; repeated requests are counted. No APK execution or server validation.'}
# Inspect current deliverable local links, including #L ranges and heading anchors.
docs=['登录与协议分析.md','REA使用说明.md','protocol_catalog.md','REA模型清单.md','REA请求模型复核.md','REA网络复核.md']
links=0;bad=[]
for name in docs:
 path=A/name;text=path.read_text(encoding='utf8')
 for m in re.finditer(r'\]\((?:<([^>]+)>|([^\s)]+))\)',text):
  ref=m[1] or m[2]
  if re.match(r'\w+://',ref):continue
  target,_,anchor=ref.partition('#');file=(path.parent/urllib.parse.unquote(target)).resolve() if target else path
  links+=1
  if not file.is_file():bad.append((name,ref,'missing file'));continue
  if anchor.startswith('L'):
   mm=re.fullmatch(r'L(\d+)(?:-L?(\d+))?',anchor)
   if mm:
    n=len(file.read_text(encoding='utf8').splitlines());end=int(mm[2] or mm[1])
    if not(1<=int(mm[1])<=end<=n):bad.append((name,ref,'line out of range'))
  elif anchor and file.suffix=='.md':
   heads=[re.sub(r'[^\w\- ]','',h.lower()).strip().replace(' ','-') for h in re.findall(r'^#{1,6} (.+)$',file.read_text(encoding='utf8'),re.M)]
   if urllib.parse.unquote(anchor) not in heads:bad.append((name,ref,'heading missing'))
report['local_links_checked']=links;report['link_errors']=bad
(A/'rea_audit.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf8')
print(json.dumps(report,ensure_ascii=False,indent=2))
assert not bad, 'Deliverable link errors'
