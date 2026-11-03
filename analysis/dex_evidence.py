"""Extract offline DEX annotations, exact method IDs and selected instruction evidence.
Not a Java decompiler or runtime trace; reads standard DEX from the original APK.
"""
import struct, zipfile, json, re, hashlib
from paths import APK, OUT

def uleb(d, p):
    v = s = 0
    while True:
        b = d[p]; p += 1; v |= (b & 127) << s
        if b < 128: return v, p
        s += 7
        if s > 35: raise ValueError('invalid ULEB128')

class Dex:
    def __init__(self, data, name):
        self.d, self.name = data, name
        d = data
        self.strings = []
        n, off = struct.unpack_from('<II', d, 56)
        for i in range(n):
            p = struct.unpack_from('<I', d, off + 4*i)[0]
            _, p = uleb(d,p)
            e = d.index(b'\0',p)
            self.strings.append(d[p:e].replace(b'\xc0\x80',b'\0').decode('utf-8','replace'))
        n, off = struct.unpack_from('<II',d,64)
        self.types = [self.strings[struct.unpack_from('<I',d,off+4*i)[0]] for i in range(n)]
        n, off = struct.unpack_from('<II',d,72)
        self.protos = []
        for i in range(n):
            _, ret, params = struct.unpack_from('<III',d,off+12*i)
            ids = [] if not params else struct.unpack_from('<'+'H'*struct.unpack_from('<I',d,params)[0],d,params+4)
            self.protos.append('('+''.join(self.types[x] for x in ids)+')'+self.types[ret])
        n, off = struct.unpack_from('<II',d,80)
        self.fields = []
        for i in range(n):
            cls, typ, nm = struct.unpack_from('<HHI',d,off+8*i)
            self.fields.append(self.types[cls]+'->'+self.strings[nm]+':'+self.types[typ])
        n, off = struct.unpack_from('<II',d,88)
        self.methods = []
        for i in range(n):
            cls, proto, nm = struct.unpack_from('<HHI',d,off+8*i)
            self.methods.append({'index':i,'class':self.types[cls], 'name':self.strings[nm], 'prototype':self.protos[proto],
                                 'id':self.types[cls]+'->'+self.strings[nm]+self.protos[proto]})
        self.defined = []
        self.class_annotations = {}
        n, off = struct.unpack_from('<II',d,96)
        for i in range(n):
            cls, flags, superclass, interfaces, source, anno, cd, statics = struct.unpack_from('<8I',d,off+32*i)
            annotations, method_annotations, parameter_annotations = {}, {}, {}
            if anno:
                co, nf, nm, np = struct.unpack_from('<4I',d,anno)
                self.class_annotations[self.types[cls]] = self.annos(co)
                base = anno+16+8*nf
                for j in range(nm):
                    mid, ao = struct.unpack_from('<II',d,base+8*j)
                    method_annotations[mid] = self.annos(ao)
                base += 8*nm
                for j in range(np):
                    mid, ref_off = struct.unpack_from('<II', d, base+8*j)
                    ref_count = struct.unpack_from('<I', d, ref_off)[0]
                    parameter_annotations[mid] = [self.annos(struct.unpack_from('<I', d, ref_off+4+4*k)[0]) for k in range(ref_count)]
            if not cd: continue
            p = cd; counts = []
            for _ in range(4):
                val,p = uleb(d,p); counts.append(val)
            for _ in range(counts[0]+counts[1]):
                _,p = uleb(d,p); _,p = uleb(d,p)
            for count in counts[2:]:
                mid = 0
                for _ in range(count):
                    diff,p = uleb(d,p); mid += diff
                    access,p = uleb(d,p); code,p = uleb(d,p)
                    self.defined.append({**self.methods[mid], 'dex':name,'access':access,'code_offset':code,
                                         'annotations':method_annotations.get(mid,[]), 'parameter_annotations':parameter_annotations.get(mid,[])})

    def value(self,p):
        b = self.d[p]; p += 1; typ = b & 31; size = (b>>5)+1
        if typ == 0x1c:
            n,p = uleb(self.d,p); a=[]
            for _ in range(n):
                v,p = self.value(p); a.append(v)
            return a,p
        if typ == 0x1d: return self.annotation(p)
        if typ == 0x1e: return None,p
        if typ == 0x1f: return bool(b>>5),p
        raw = int.from_bytes(self.d[p:p+size],'little'); p += size
        if typ == 0x17: return self.strings[raw],p
        if typ == 0x18: return self.types[raw],p
        if typ in (0x19,0x1b): return self.fields[raw],p
        if typ == 0x1a: return self.methods[raw]['id'],p
        return {'encoded_type':typ,'raw':raw,'size':size},p

    def annotation(self,p):
        typ,p = uleb(self.d,p); n,p = uleb(self.d,p); vals={}
        for _ in range(n):
            name,p = uleb(self.d,p); val,p = self.value(p); vals[self.strings[name]]=val
        return {'type':self.types[typ],'values':vals},p

    def annos(self,off):
        if not off: return []
        n=struct.unpack_from('<I',self.d,off)[0]; result=[]
        for i in range(n):
            p=struct.unpack_from('<I',self.d,off+4+4*i)[0]
            a,_=self.annotation(p+1); result.append(a)
        return result

    def instructions(self,m):
        off=m['code_offset']
        if not off: return []
        nr,ni,no,nt,debug,n = struct.unpack_from('<HHHHII',self.d,off)
        words=struct.unpack_from('<'+'H'*n,self.d,off+16)
        out=[]; p=0
        while p<n:
            op=words[p]&255; w=words[p]
            if op==0 and w>>8:
                sub=w>>8
                width=(4+2*words[p+1]) if sub==1 else (2+4*words[p+1]) if sub==2 else (4+(words[p+1]*(words[p+2]|words[p+3]<<16)+1)//2) if sub==3 else 1
                out.append({'pc':p,'opcode':'payload','words':list(words[p:p+width])}); p+=width; continue
            width = WIDTH.get(op,1)
            ins={'pc':p,'opcode':NAMES.get(op,f'op_{op:02x}'),'words':list(words[p:p+width])}
            if op in (0x1a,0x1b):
                idx=words[p+1] if op==0x1a else words[p+1]|words[p+2]<<16
                ins['string']=self.strings[idx]
            elif op in list(range(0x6e,0x73))+list(range(0x74,0x79))+( [0xfa,0xfb]):
                ins['method']=self.methods[words[p+1]]['id']
            elif 0x52<=op<=0x6d: ins['field']=self.fields[words[p+1]]
            elif op in (0x1c,0x1f,0x20,0x22,0x23,0x24,0x25): ins['type']=self.types[words[p+1]]
            if op==0x12:
                val=(w>>12); ins['literal']=val-16 if val>=8 else val
            elif op in (0x13,0x16):
                val=words[p+1]; ins['literal']=val-65536 if val>=32768 else val
            elif op in (0x14,0x17):
                val=words[p+1]|words[p+2]<<16; ins['literal']=val-(1<<32) if val>=1<<31 else val
            elif op==0x18:
                ins['literal']=sum(words[p+j+1]<<(16*j) for j in range(4))
            out.append(ins); p+=width
        return out

WIDTH = {op:2 for op in list(range(0x2d,0x3e))+list(range(0x44,0x6e))+list(range(0x90,0xb0))+list(range(0xd0,0xe3))}
WIDTH.update({op:3 for op in list(range(0x6e,0x73))+list(range(0x74,0x79))+[3,6,9,0x14,0x17,0x1b,0x24,0x25,0x26,0x2a,0x2b,0x2c,0xfc,0xfd]})
WIDTH.update({op:2 for op in [2,5,8,0x13,0x15,0x16,0x19,0x1a,0x1c,0x1f,0x20,0x22,0x23,0x29,0xfe,0xff]})
WIDTH.update({0x18:5,0xfa:4,0xfb:4})
NAMES={0:'nop',1:'move',2:'move/from16',3:'move/16',4:'move-wide',7:'move-object',8:'move-object/from16',9:'move-object/16',0x0a:'move-result',0x0b:'move-result-wide',0x0c:'move-result-object',0x0e:'return-void',0x0f:'return',0x10:'return-wide',0x11:'return-object',0x12:'const/4',0x13:'const/16',0x14:'const',0x15:'const/high16',0x16:'const-wide/16',0x17:'const-wide/32',0x18:'const-wide',0x19:'const-wide/high16',0x1a:'const-string',0x1b:'const-string/jumbo',0x1c:'const-class',0x1f:'check-cast',0x20:'instance-of',0x22:'new-instance',0x23:'new-array',0x24:'filled-new-array',0x25:'filled-new-array/range',0x26:'fill-array-data',0x27:'throw',0x28:'goto',0x29:'goto/16',0x2a:'goto/32',0x2b:'packed-switch',0x2c:'sparse-switch'}
for start,names in [(0x52,['iget','iget-wide','iget-object','iget-boolean','iget-byte','iget-char','iget-short','iput','iput-wide','iput-object','iput-boolean','iput-byte','iput-char','iput-short','sget','sget-wide','sget-object','sget-boolean','sget-byte','sget-char','sget-short','sput','sput-wide','sput-object','sput-boolean','sput-byte','sput-char','sput-short']),(0x6e,['invoke-virtual','invoke-super','invoke-direct','invoke-static','invoke-interface']),(0x74,['invoke-virtual/range','invoke-super/range','invoke-direct/range','invoke-static/range','invoke-interface/range']),(0x32,['if-eq','if-ne','if-lt','if-ge','if-gt','if-le','if-eqz','if-nez','if-ltz','if-gez','if-gtz','if-lez'])]:
    NAMES.update({start+i:n for i,n in enumerate(names)})

def main():
    # Annotation paths remain reliable even when R8 renames methods and annotation types.
    report={'apk_sha256':hashlib.sha256(APK.read_bytes()).hexdigest(),'note':'Static original DEX evidence only. Incoming references are not observed execution.','endpoints':[],'interesting_methods':[]}
    needles={'HmacSHA256','api-key','signature','nonce','pica_nonce','auth_token','refresh_token','saved_password','saved_username','authorization','https://picaapi.picacomic.com/','http://68.183.234.72/init','https://pica-ad-api.diwodiwo.xyz'}
    dexes=[]
    with zipfile.ZipFile(APK) as z:
        for name in z.namelist():
            if re.fullmatch(r'classes\d*\.dex',name): dexes.append(Dex(z.read(name),name))
    for dex in dexes:
        for m in dex.defined:
            annotations=json.dumps(m['annotations'],ensure_ascii=False)
            if m['annotations'] and re.search(r'auth/|users/|comics/|games/|categories|announcements|banners|collections|keywords|leaderboard|favourites|picacomic|zones|recommend|track|mapping|init|version',annotations):
                report['endpoints'].append(m)
            instructions=dex.instructions(m)
            hits=sorted({x['string'] for x in instructions if 'string' in x and x['string'] in needles})
            if hits or m['class'] in ('Lcom/picacg/network/pica/api/SignInRequest;','Lcom/picacg/network/pica/model/LoginData;'):
                report['interesting_methods'].append({**m,'hits':hits,'instructions':instructions})
    selected={m['id'] for m in report['interesting_methods']}
    report['incoming_references']=[]
    for dex in dexes:
        for m in dex.defined:
            for ins in dex.instructions(m):
                if ins.get('method') in selected:
                    report['incoming_references'].append({'caller':m['id'],'dex':dex.name,'pc':ins['pc'],'target':ins['method']})
    (OUT/'dex_protocol_evidence.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
    lines=['# Original DEX protocol evidence','',f"APK SHA256: {report['apk_sha256']}",'','Static extraction; instruction offsets below are 16-bit code units, not source lines.','']
    for group in ('endpoints','interesting_methods'):
        lines += ['## '+group,'']
        for m in report[group]:
            lines += ['### '+m['id'],f"DEX: {m['dex']}; method index {m['index']}; code offset 0x{m['code_offset']:x}"]
            if m['annotations']: lines += ['Annotations: '+json.dumps(m['annotations'],ensure_ascii=False)]
            if 'instructions' in m:
                lines += ['Hits: '+json.dumps(m['hits'],ensure_ascii=False),'```text']
                for ins in m['instructions']:
                    detail=ins.get('string',ins.get('method',ins.get('field',ins.get('type',ins.get('literal','')))))
                    lines.append(f"{ins['pc']:04x}: {ins['opcode']:<24} {' '.join(f'{w:04x}' for w in ins['words'])} {json.dumps(detail,ensure_ascii=False)}")
                lines += ['```']
            lines += ['']
    (OUT/'dex_protocol_evidence.md').write_text('\n'.join(lines),encoding='utf-8')
    print(json.dumps({'endpoints':len(report['endpoints']),'interesting_methods':len(report['interesting_methods']),'incoming_references':len(report['incoming_references']),'output':str(OUT/'dex_protocol_evidence.json')},indent=2))

if __name__ == '__main__':
    main()
