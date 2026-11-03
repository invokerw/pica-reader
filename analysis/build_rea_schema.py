"""Compare REA-returned serializer descriptor keys/optionality with original DEX.
Produces evidence-backed wire-key catalogs, not a guessed server schema or runtime observation.
"""
from pathlib import Path
import json,re,zipfile,collections
from dex_evidence import Dex,APK
ROOT=Path(__file__).resolve().parents[1]; A=ROOT/'analysis'
frozen=json.loads((A/'remaining_targets.json').read_text(encoding='utf8'))
indexes=[]
for batch in ('core','validation','supplement','closure'):
    p=A/'rea'/batch/'index.json'
    if p.exists():indexes+=json.loads(p.read_text(encoding='utf8'))
method_items=collections.defaultdict(list)
for i in indexes:
    t=i.get('original_task',{})
    if i.get('ok') and i.get('source_file') and i['operation']=='inspect_android_method':
        method_items[t.get('original_method_id','')].append(i)
def item_for(cls,name):
    matches=[i for mid,items in method_items.items() if mid.startswith(cls+'->'+name+'(') for i in items]
    return matches

def regs(ins):
    w=ins['words']; op=w[0]&255
    if op in range(0x6e,0x73):
        return [(w[2]>>(4*k))&15 for k in range(4)][:w[0]>>12]+([w[0]>>8&15] if w[0]>>12==5 else [])
    if op in range(0x74,0x79):return list(range(w[2],w[2]+(w[0]>>8)))
    return []
def dex_keys(d,m):
    state={};out=[]
    for ins in d.instructions(m):
        w=ins['words'][0];op=w&255
        if 'string' in ins:state[w>>8]=ins['string']
        elif 'literal' in ins:state[(w>>8)&15 if op==0x12 else w>>8]=ins['literal']
        elif op in (1,4,7):state[(w>>8)&15]=state.get(w>>12)
        elif op in (2,5,8):state[w>>8]=state.get(ins['words'][1])
        elif op in (3,6,9):state[ins['words'][1]]=state.get(ins['words'][2])
        if ins.get('method')=='Lqj4;->j(Ljava/lang/String;Z)V':
            rr=regs(ins);k=state.get(rr[1]);v=state.get(rr[2])
            if not isinstance(k,str) or v not in (0,1):raise ValueError('Unresolved descriptor registration '+m['id'])
            out.append({'key':k,'optional':bool(v),'original_pc':hex(ins['pc'])})
    return out

def rea_keys(path):
    lines=Path(path).read_text(encoding='utf8').splitlines();state={};out=[]
    if str(path).endswith('.smali'):
        for ln,line in enumerate(lines,1):
            q=re.search(r'const-string(?:/jumbo)? (\w+), "(.*)"',line)
            if q:state[q[1]]=q[2]
            q=re.search(r'const/(?:4|16) (\w+), (0x[0-9a-f]+|\d+)',line)
            if q:state[q[1]]=int(q[2],0)
            q=re.search(r'move(?:-object)?(?:/from16|/16)? (\w+), (\w+)',line)
            if q:state[q[1]]=state.get(q[2])
            if 'Lqj4;->j(Ljava/lang/String;Z)V' in line:
                rr=re.search(r'\{([^}]+)\}',line)[1].replace(' ','').split(',');k=state.get(rr[1]);v=state.get(rr[2])
                if not isinstance(k,str) or v not in (0,1):raise ValueError('Unresolved REA descriptor '+str(path))
                out.append({'key':k,'optional':bool(v),'source_line':ln})
    else:
        for ln,line in enumerate(lines,1):
            for q in re.finditer(r'\.j\("([^"\n]+)", (true|false)\)',line):out.append({'key':q[1],'optional':q[2]=='true','source_line':ln})
    return out

def split_top(expr):
    out=[];start=0;level=0
    for i,c in enumerate(expr):
        if c in '([{':level+=1
        elif c in ')]}':level-=1
        elif c==',' and level==0:out.append(expr[start:i].strip());start=i+1
    out.append(expr[start:].strip());return out

def child_expr(path):
    text=Path(path).read_text(encoding='utf8');q=re.search(r'return new ca3\[\]\{(.*)\};',text,re.S)
    if not q:return []
    variables={}
    for line in text.splitlines():
        a=re.match(r'\s*(?:ca3|ix5|e53|[a-z0-9]+) (\w+) = (.*);',line)
        if a:variables[a[1]]=a[2]
    out=split_top(q[1])
    for _ in range(4):
        out=[re.sub(r'\b('+ '|'.join(map(re.escape,variables))+r')\b',lambda m:'('+variables[m[0]]+')',e) if variables else e for e in out]
    return out

models=[]
with zipfile.ZipFile(APK) as z:
    ds=[Dex(z.read(n),n) for n in z.namelist() if re.fullmatch(r'classes\d*\.dex',n)]
    defs={m['id']:(d,m) for d in ds for m in d.defined}
    groups=[]
    for g in frozen['dto_targets']:
        s=g.get('serializer')
        if s and g['descriptor'] != 'Lq83;':groups.append((g['descriptor'],s['descriptor'])) # JsonElement is the generic JSON tree, not a generated PICA record.
    for g in frozen['nested_pica_model_targets']:
        if g.get('serializer_descriptor'):groups.append((g['descriptor'],g['serializer_descriptor']))
    for cls,serializer in sorted(set(groups)):
        candidates=[(d,m) for d in ds for m in d.defined if m['class']==serializer and m['name'] in {'<clinit>','<init>'}]
        entries=[];sources=[]
        for d,m in candidates:
            keys=dex_keys(d,m)
            if not keys:continue
            rea=method_items.get(m['id'],[])
            verified=None
            for i in rea:
                rk=rea_keys(i['source_file'])
                if [(k['key'],k['optional']) for k in rk]==[(k['key'],k['optional']) for k in keys]:verified=(i,rk);break
            if not verified:raise ValueError('No matching real REA descriptor '+m['id'])
            i,rk=verified;source=Path(i['source_file']).relative_to(A).as_posix();sources.append(source)
            entries=[{**k,'rea_source':source,'rea_line':r['source_line']} for k,r in zip(keys,rk)]
            break
        if not entries:raise ValueError('No descriptor '+cls)
        children=item_for(serializer,'childSerializers');expressions=[];childsource=None
        for i in children:
            expressions=child_expr(i['source_file'])
            if expressions:childsource=Path(i['source_file']).relative_to(A).as_posix();break
        for n,k in enumerate(entries):
            k['index']=n;k['serializer_expression']=expressions[n] if n<len(expressions) else None
            k['nullable']=True if k['serializer_expression'] and 'uo3.M(' in k['serializer_expression'] else None
        ctors=item_for(cls,'<init>')
        models.append({'class_descriptor':cls,'serializer_descriptor':serializer,'wire_fields':entries,'child_serializers_source':childsource,'constructor_sources':[Path(i['source_file']).relative_to(A).as_posix() for i in ctors], 'notes':'optional means missing field allowed; not the same as nullable. Raw serializer expressions retained, unresolved lazy/generic child types are not invented.'})
summary={'schema_version':1,'scope':'Static client serialization contracts, REA descriptor registrations cross-checked against original DEX; not live server responses.','model_count':len(models),'wire_field_count':sum(len(m['wire_fields']) for m in models),'models':models}
(A/'rea_model_schema.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2),encoding='utf8')
lines=['# REA 序列化模型清单','',f"已对照 **{len(models)} 个模型、{summary['wire_field_count']} 个字段注册**：REA Java/smali 的 descriptor key/optional 与原 APK DEX 一致。",'', '这是客户端接受/写出的静态结构，不保证服务器实际返回。`必填`仅指缺字段校验；`可省略`不等于可为 null。默认值应以链接的构造器为准。泛型/懒加载子模型保留真实 serializer 表达式，不猜类型。','', '[机器可读完整清单](rea_model_schema.json)；[接口清单](protocol_catalog.md)。','']
for m in models:
    name=m['class_descriptor'][1:-1].split('/')[-1];lines+=['## '+name,'',f"Serializer：`{m['serializer_descriptor']}`。",'', '| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |','|---|---|---|---|']
    for k in m['wire_fields']:
        expr=(k['serializer_expression'] or '参见 childSerializers 原文').replace('|','\\|')
        lines.append(f"| `{k['key']}` | {'可省略' if k['optional'] else '必填'} | `{expr}` | [descriptor]({k['rea_source']}#L{k['rea_line']}) |")
    if m['child_serializers_source']:lines+=['',f"[childSerializers]({m['child_serializers_source']})。"]
    if m['constructor_sources']:lines+=['','构造器/defaults：'+ '、'.join(f'[证据 {n+1}]({p})' for n,p in enumerate(m['constructor_sources']))+'。']
    lines+=['']
(A/'REA模型清单.md').write_text('\n'.join(lines),encoding='utf8')
print('Models',len(models),'fields',summary['wire_field_count'],'nullable expressions',sum(k['nullable'] is True for m in models for k in m['wire_fields']))
