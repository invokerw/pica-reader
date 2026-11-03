"""Read Android binary XML manifest offline without SDK or APK execution."""
import zipfile, struct, json, html
from paths import APK, OUT, require_apk

def length8(d,p):
    x=d[p]; p+=1
    if x&128: x=((x&127)<<8)|d[p];p+=1
    return x,p

def length16(d,p):
    x=struct.unpack_from('<H',d,p)[0];p+=2
    if x&32768: x=((x&32767)<<16)|struct.unpack_from('<H',d,p)[0];p+=2
    return x,p

def decode(d):
    strings=[]; events=[];pos=struct.unpack_from('<H',d,2)[0]
    while pos<len(d):
        typ,head,size=struct.unpack_from('<HHI',d,pos)
        if size<8: raise ValueError('invalid AXML chunk')
        if typ==1:
            count,styles,flags,start,style=struct.unpack_from('<5I',d,pos+8)
            for i in range(count):
                off=struct.unpack_from('<I',d,pos+head+4*i)[0];p=pos+start+off
                if flags&256:
                    _,p=length8(d,p);n,p=length8(d,p);s=d[p:p+n].decode('utf-8','replace')
                else:
                    n,p=length16(d,p);s=d[p:p+n*2].decode('utf-16-le','replace')
                strings.append(s)
        elif typ==0x102:
            ns,name,attrstart,attrsize,count,idx,cl,st=struct.unpack_from('<II6H',d,pos+16)
            attrs={}
            for i in range(count):
                p=pos+16+attrstart+i*attrsize
                ans,aname,raw,vs,res,vtype,val=struct.unpack_from('<IIIHBBI',d,p)
                if raw!=0xffffffff: v=strings[raw]
                elif vtype==3:v=strings[val]
                elif vtype==0x12:v=bool(val)
                elif vtype==0x10:v=val
                elif vtype in (1,2):v=f'@0x{val:08x}'
                else:v={'type':vtype,'data':val}
                key=('android:' if ans!=0xffffffff and strings[ans]=='http://schemas.android.com/apk/res/android' else '')+strings[aname]
                attrs[key]=v
            events.append({'event':'start','name':strings[name],'attributes':attrs})
        elif typ==0x103:
            ns,name=struct.unpack_from('<II',d,pos+16)
            events.append({'event':'end','name':strings[name]})
        pos+=size
    return events

require_apk()
with zipfile.ZipFile(APK) as z: events=decode(z.read('AndroidManifest.xml'))
(OUT/'manifest.json').write_text(json.dumps(events,ensure_ascii=False,indent=2),encoding='utf-8')
lines=[];depth=0
for e in events:
    if e['event']=='end':
        depth-=1;lines.append('  '*depth+'</'+e['name']+'>')
    else:
        attr=' '.join(k+'="'+html.escape(str(v),quote=True)+'"' for k,v in e['attributes'].items())
        lines.append('  '*depth+'<'+e['name']+(' '+attr if attr else '')+'>');depth+=1
(OUT/'AndroidManifest.decoded.xml').write_text('\n'.join(lines),encoding='utf-8')
for e in events:
    if e['event']=='start' and e['name'] in ('manifest','uses-sdk','uses-permission','application','activity'):print(json.dumps(e,ensure_ascii=False))
