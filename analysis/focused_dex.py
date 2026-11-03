"""Targeted static DEX dump and endpoint extraction; no network or target execution."""
from dex_evidence import Dex, NAMES, APK, OUT
import zipfile, re, json, struct
NAMES.update({0x0d:'move-exception',0x81:'int-to-long',0x84:'long-to-int',0xbe:'div-long/2addr',0x95:'and-int',0xb1:'sub-int/2addr'})

EXACT = {'Lc31;':{'n','x'}, 'Lkx5;':{'A0'}, 'Lrx5;':{'d0','f0'}, 'Lkx3;':{'invoke'}, 'Llx2;':{'b','d'}, 'Ldo0;':{'<clinit>'}, 'Ll31;':{'invokeSuspend'}, 'Lbb3;':{'invokeSuspend'}, 'Leo3;':{'c'}, 'Lhi6;':{'c'}, 'Ldg4;':{'a'}, 'Lqy2;':{'a'}, 'Lto5;':{'<clinit>'}, 'Lcom/picacg/network/pica/model/PicaResponse$$serializer;':{'<init>'}, 'Lcom/picacg/network/pica/model/LoginData$$serializer;':{'<clinit>'}}
ALL = {'Lnh4;','Ls42;','Lcom/picacg/network/pica/model/PicaResponse;','Lcom/picacg/network/pica/api/SignInRequest;','Lcom/picacg/network/pica/model/LoginData;'}
ANNOTATIONS={'Lfn2;','Ln94;','Lo94;'}

def regdetail(i):
    w=i['words']; op=w[0]&255; a=w[0]>>8
    if op in range(0x6e,0x73):
        count=w[0]>>12; regs=[w[2]&15,(w[2]>>4)&15,(w[2]>>8)&15,(w[2]>>12)&15,(w[0]>>8)&15][:count]
        return '{'+', '.join('v'+str(x) for x in regs)+'}'
    if op in range(0x74,0x79): return '{'+', '.join('v'+str(x) for x in range(w[2],w[2]+a))+'}'
    if 0x52<=op<=0x5f or op in (1,4,7,0x81,0x84,0xbe,0xb1): return f'v{a&15}, v{a>>4}'
    if op in (2,5,8): return f'v{a}, v{w[1]}'
    if op in (3,6,9): return f'v{w[1]}, v{w[2]}'
    if op in (0xa,0xb,0xc,0xd,0xe,0xf,0x10,0x11,0x13,0x16,0x1a,0x1f,0x22) or 0x60<=op<=0x6d: return f'v{a}'
    if op==0x12: return f'v{a&15}, {i.get("literal")}'
    return ''

with zipfile.ZipFile(APK) as z:
    dexes=[Dex(z.read(n),n) for n in z.namelist() if re.fullmatch(r'classes\d*\.dex',n)]
selected=[]; endpoints=[]; maps=[]; class_listing={}
for d in dexes:
    for m in d.defined:
        if m['class'] in ALL or m['class'] in EXACT:
            class_listing.setdefault(m['class'],[]).append(m['id'])
        ins=d.instructions(m)
        http=[a for a in m['annotations'] if a['type'] in ANNOTATIONS]
        if http:
            endpoints.append({**m,'http_annotations':http})
        if m['class'] in ALL or m['name'] in EXACT.get(m['class'],set()):
            selected.append({**m,'registers':struct.unpack_from('<HHHH',d.d,m['code_offset']) if m['code_offset'] else [],'instructions':ins})
        if any(i.get('type') in ANNOTATIONS for i in ins) and any(i.get('string') in {'GET','POST','PUT','DELETE','PATCH'} for i in ins):
            maps.append({**m,'instructions':ins})

report={'class_listing':class_listing,'endpoints':endpoints,'target_methods':selected,'http_annotation_parsers':maps}
(OUT/'focused_dex.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
lines=['# Targeted original DEX evidence','', 'Original bytecode only; register decoding is partial. No runtime behavior asserted.','']
for category,methods in [('Target methods',selected),('HTTP annotation parser',maps)]:
    lines+=['## '+category,'']
    for m in methods:
        lines+=['### '+m['id'],f"DEX {m['dex']}; index {m['index']}; code 0x{m['code_offset']:x}; registers {m.get('registers',[])}",'```text']
        for i in m['instructions']:
            detail=i.get('string',i.get('method',i.get('field',i.get('type',i.get('literal','')))))
            lines.append(f"{i['pc']:04x}: {i['opcode']:<25} {regdetail(i):<28} {' '.join(f'{w:04x}' for w in i['words'])} {json.dumps(detail,ensure_ascii=False)}")
        lines+=['```','']
(OUT/'focused_dex.md').write_text('\n'.join(lines),encoding='utf-8')
endpoint_lines=['# Actual HTTP annotation inventory','','Only GET/POST/PUT annotations found in the original DEX. Each parameter slot includes original annotation descriptors.','']
for m in endpoints:
    endpoint_lines += ['## '+m['id'], 'HTTP: '+json.dumps(m['http_annotations'],ensure_ascii=False), 'Method annotations: '+json.dumps(m['annotations'],ensure_ascii=False), 'Parameter annotations: '+json.dumps(m.get('parameter_annotations',[]),ensure_ascii=False), '']
(OUT/'http_endpoints.md').write_text('\n'.join(endpoint_lines),encoding='utf-8')
print(json.dumps({'endpoints':len(endpoints),'targets':len(selected),'annotation_parsers':[m['id'] for m in maps]},ensure_ascii=False,indent=2))
