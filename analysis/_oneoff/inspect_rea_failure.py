from pathlib import Path
import json
p=Path(__file__).parent/'rea'/'cli-package-attempt2.json'
v=json.loads(p.read_text(encoding='utf-8'))
# Inspect already collected output; do not execute or relaunch target/engine.
f=p.parent/'cli-attempt2-stderr.txt'
f.write_text(v.get('details',{}).get('captured_output',{}).get('stderr',''),encoding='utf-8')
print('wrote',f)
print(json.dumps({k:x for k,x in v.get('details',{}).items() if k!='captured_output'},indent=2))
