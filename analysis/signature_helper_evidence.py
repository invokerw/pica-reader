"""Export the last signer helper/request-constructor proof from original DEX."""
from dex_evidence import Dex, APK, OUT
import zipfile, json, re

ids={
    'Lsx;->i0([BLjava/lang/String;Llm2;I)Ljava/lang/String;',
    'Lkx3;-><init>(I)V',
    'Lkx3;->invoke(Ljava/lang/Object;)Ljava/lang/Object;',
    'Lk30;->s(Ljava/lang/String;Lo55;)V',
    'Lhr2;->E(Ljava/lang/String;)Z',
    'Lzx;-><init>(Lk30;)V',
    'Lzx;->toString()Ljava/lang/String;'
}
lines=['# Signing helper and HTTP request evidence','','Original DEX only, no APK execution. PCs are 16-bit code-unit offsets; code offsets are bytes within each DEX.','']
found=[]
with zipfile.ZipFile(APK) as z:
    for n in z.namelist():
        if not re.fullmatch(r'classes\d*\.dex',n): continue
        d=Dex(z.read(n),n)
        for m in d.defined:
            if m['id'] not in ids: continue
            found.append(m['id'])
            lines += ['## '+m['id'],f"DEX {n}; method_idx {m['index']}; code_off 0x{m['code_offset']:x}",'```text']
            for i in d.instructions(m):
                detail=i.get('string',i.get('method',i.get('field',i.get('type',i.get('literal','')))))
                lines.append(f"{i['pc']:04x}: {i['opcode']:<25} {' '.join(f'{w:04x}' for w in i['words'])} {json.dumps(detail,ensure_ascii=False)}")
            lines += ['```','']
assert set(found)==ids, ids-set(found)
(OUT/'signature_helper_evidence.md').write_text('\n'.join(lines),encoding='utf-8')
print('Exported',len(found),'original DEX methods')
