"""Offline APK inventory and original DEX identity probe (no APK execution)."""
import zipfile, struct, json, hashlib, re

from paths import APK, OUT, relpath, require_apk

require_apk()

def uleb(data, off):
    value = 0
    shift = 0
    while True:
        b = data[off]
        off += 1
        value |= (b & 0x7f) << shift
        if not b & 0x80:
            return value, off
        shift += 7
        if shift > 35:
            raise ValueError('Invalid ULEB128')

def dex_probe(data):
    if not data.startswith(b'dex\n'):
        raise ValueError('Not standard DEX')
    string_count, string_off = struct.unpack_from('<II', data, 56)
    type_count, type_off = struct.unpack_from('<II', data, 64)
    method_count, method_off = struct.unpack_from('<II', data, 88)
    class_count, class_off = struct.unpack_from('<II', data, 96)
    strings = []
    for i in range(string_count):
        off = struct.unpack_from('<I', data, string_off + i * 4)[0]
        _, off = uleb(data, off)
        end = data.index(b'\0', off)
        strings.append(data[off:end].replace(b'\xc0\x80', b'\0').decode('utf-8', 'replace'))
    types = [strings[struct.unpack_from('<I', data, type_off + i * 4)[0]] for i in range(type_count)]
    methods = []
    for i in range(method_count):
        cls, proto, name = struct.unpack_from('<HHI', data, method_off + i * 8)
        methods.append({'class': types[cls], 'name': strings[name], 'prototype_index': proto})
    classes = []
    native = []
    for i in range(class_count):
        cls, flags, superclass, interfaces, source, annotations, clsdata, statics = struct.unpack_from('<8I', data, class_off + i * 32)
        classes.append(types[cls])
        if not clsdata:
            continue
        p = clsdata
        counts = []
        for _ in range(4):
            n, p = uleb(data, p)
            counts.append(n)
        for _ in range(counts[0] + counts[1]):
            _, p = uleb(data, p)
            _, p = uleb(data, p)
        for count in counts[2:]:
            mid = 0
            for _ in range(count):
                diff, p = uleb(data, p)
                mid += diff
                access, p = uleb(data, p)
                code, p = uleb(data, p)
                if access & 0x100:
                    native.append({**methods[mid], 'access_flags': access, 'code_offset': code})
    return {'version': data[4:7].decode(), 'string_count': string_count, 'method_count': method_count,
            'class_count': class_count, 'classes': classes, 'native_methods': native}, strings

report = {'apk': APK.name, 'size': APK.stat().st_size, 'sha256': hashlib.sha256(APK.read_bytes()).hexdigest(), 'entries': [], 'dex': [], 'native_libraries': []}
with zipfile.ZipFile(APK) as z:
    for entry in z.infolist():
        report['entries'].append({'path': entry.filename, 'size': entry.file_size, 'compressed': entry.compress_size})
        if re.fullmatch(r'classes\d*\.dex', entry.filename):
            data = z.read(entry)
            facts, strings = dex_probe(data)
            report['dex'].append({'path': entry.filename, **facts})
            (OUT / (entry.filename + '.classes.txt')).write_text('\n'.join(facts['classes']), encoding='utf-8')
            (OUT / (entry.filename + '.strings.txt')).write_text('\n'.join(f'{i}\t{json.dumps(s, ensure_ascii=False)}' for i, s in enumerate(strings)), encoding='utf-8')
        elif entry.filename.startswith('lib/') and entry.filename.endswith('.so'):
            data = z.read(entry)
            dest = OUT / 'native' / entry.filename
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.write_bytes(data)
            printable = re.findall(rb'[\x20-\x7e]{5,}', data)
            text = '\n'.join(s.decode('ascii') for s in printable)
            dest.with_suffix('.so.strings.txt').write_text(text, encoding='utf-8')
            report['native_libraries'].append({'path': entry.filename, 'size': len(data), 'sha256': hashlib.sha256(data).hexdigest(), 'extracted_path': relpath(dest)})
(OUT / 'apk_inventory.json').write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding='utf-8')
print(json.dumps({k: v for k, v in report.items() if k not in ('entries','dex')}, ensure_ascii=False, indent=2))
for dex in report['dex']:
    print(json.dumps({k: v for k,v in dex.items() if k not in ('classes',)}, ensure_ascii=False, indent=2))
