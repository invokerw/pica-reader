"""Download audited tools to project-local .rea-tools; no APK execution.
Run only after user requests REA deployment. Verifies SHA256 before extraction.
Never modifies global runtime/client settings, never deletes or overwrites files.
"""
from pathlib import Path
import urllib.request, hashlib, json, zipfile, concurrent.futures, shutil

ROOT=Path(__file__).resolve().parent.parent
TOOLS=ROOT/'.rea-tools'
ASSETS=[
 {'name':'jdk21.zip','url':'https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.13%2B9/OpenJDK21U-jdk_x64_windows_hotspot_21.0.13_9.zip','sha256':'a4dbaa05fca4bd89d84584e58c459bd732efebb1722af80ab13c6516832004f9'},
 {'name':'jadx-headless-mcp-0.7.1-all.jar','url':'https://github.com/1013503897/jadx-headless-mcp/releases/download/v0.7.1/jadx-headless-mcp-0.7.1-all.jar','sha256':'6e5eacf500b64292bfb73c49797c1958f6ee44646e43e868039ae7feb573ff75'}
]

def download(asset):
    p=TOOLS/asset['name']
    if p.exists():
        with p.open('rb') as f: actual=hashlib.file_digest(f,'sha256').hexdigest()
        if actual!=asset['sha256']: raise RuntimeError(f'Existing file hash mismatch, not overwritten: {p}: {actual}')
        size=p.stat().st_size
    else:
        req=urllib.request.Request(asset['url'],headers={'User-Agent':'picacg-local-analysis/1.0'})
        digest=hashlib.sha256();size=0
        with urllib.request.urlopen(req,timeout=120) as r,p.open('xb') as f:
            while b:=r.read(1024*1024): f.write(b);digest.update(b);size+=len(b)
        actual=digest.hexdigest()
        if actual!=asset['sha256']: raise RuntimeError(f'Download hash mismatch: {p}: {actual}')
    print(json.dumps({'asset':asset['name'],'bytes':size,'sha256':actual,'verified':True}),flush=True)
    return {**asset,'path':str(p),'bytes':size,'verified':True}

if __name__=='__main__':
    TOOLS.mkdir(exist_ok=True)
    free=shutil.disk_usage(ROOT).free
    if free < 1_500_000_000: raise RuntimeError(f'Insufficient workspace drive space: {free} bytes')
    print(json.dumps({'workspace':str(ROOT),'free_bytes':free}),flush=True)
    with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
        assets=list(pool.map(download,ASSETS))
    dest=TOOLS/'jdk'
    java=dest/'jdk-21.0.13+9'/'bin'/'java.exe'
    if not dest.exists():
        with zipfile.ZipFile(TOOLS/'jdk21.zip') as z:
            for m in z.infolist():
                resolved=(dest/m.filename).resolve()
                if not resolved.is_relative_to(dest.resolve()): raise RuntimeError('Unsafe archive member: '+m.filename)
            z.extractall(dest)
    if not java.is_file(): raise RuntimeError('Expected full JDK launcher missing: '+str(java))
    manifest=TOOLS/'download-manifest.json'
    with manifest.open('x',encoding='utf-8') as f:
        json.dump({'assets':assets,'JAVA_HOME':str(java.parent.parent)},f,indent=2)
    print('READY '+str(java.parent.parent),flush=True)
