"""Extract a machine-readable protocol baseline from an APK (static, offline, no execution).

The extractor never hardcodes this app's obfuscated class names: it finds the signer by
the constants it must reference, and finds HTTP endpoints by their annotation values.
Verbs are recovered from the previous baseline by path overlap, because R8 renames the
Retrofit annotation classes on every release.

    python extract_protocol.py [--verb-map Lfn2=GET,...] [--out DIR]
"""
from __future__ import annotations

import argparse
import hashlib
import hmac
import json
import re
import sys
import zipfile
from datetime import datetime, timezone
from pathlib import Path

import paths
from dex_evidence import Dex

SCHEMA = 1
SIGNER_MARKER = 'HmacSHA256'

# Header names the signer writes. Values come from the const-string pairs right after them.
HEADER_KEYS = [
    'accept', 'api-key', 'app-channel', 'app-version', 'app-build-version',
    'app-platform', 'app-uuid', 'image-quality', 'User-Agent', 'authorization',
    'time', 'nonce', 'signature',
]
DYNAMIC_HEADERS = {'time', 'nonce', 'signature', 'authorization', 'api-key', 'app-uuid', 'image-quality'}

# Archive knowledge for the very first run (2.6.73); later runs recover verbs by path overlap.
ARCHIVE_VERB_MAP = {'Lfn2;': 'GET', 'Ln94;': 'POST', 'Lo94;': 'PUT'}
ARCHIVE_PARAM_MAP = {'Ljd4;': 'Path', 'Lqq4;': 'Query', 'Lrq4;': 'QueryMap', 'Lz90;': 'Body', 'Lb26;': 'Tag'}

# Guards the extractor against its own regressions: with the archived key/secret this
# vector must reproduce the digest that pica_signature_offline.py and the Dart tests use.
ARCHIVE_VECTOR = {
    'path': '/auth/sign-in', 'query': None, 'time': 1700000000,
    'nonce': '0123456789abcdefghijklmnopqrstuv', 'method': 'POST',
    'signature': '728cf13eb37668cffb9c307b2ce4d44367318dc3b97e1e11d729f44b3c57b5d8',
}
ARCHIVE_API_KEY = 'C69BAF41DA5ABD1FFEDC6D2FEA56B'


# --------------------------------------------------------------------------- DEX

def load_dexes(apk):
    with zipfile.ZipFile(apk) as archive:
        names = sorted(n for n in archive.namelist() if re.fullmatch(r'classes\d*\.dex', n))
        return [Dex(archive.read(name), name) for name in names]


def string_sequence(dex, method):
    return [{'pc': ins['pc'], 'value': ins['string']}
            for ins in dex.instructions(method) if 'string' in ins]


def find_signer(dexes):
    """The signer is the one method that both hashes and touches the api-key header."""
    hits = []
    for dex in dexes:
        for method in dex.defined:
            seq = string_sequence(dex, method)
            values = {item['value'] for item in seq}
            if SIGNER_MARKER in values and 'api-key' in values:
                hits.append((dex, method, seq))
    if not hits:
        sys.exit('未找到签名器：没有任何方法同时引用 HmacSHA256 与 api-key。'
                 '可能是签名实现被换掉了，需要人工读反编译。')
    if len(hits) > 1:
        strong = [h for h in hits if {'app-version', 'nonce'} <= {i['value'] for i in h[2]}]
        if len(strong) == 1:
            hits = strong
        else:
            listing = '\n'.join(
                f"  {m['id']}  ({dex.name}, code 0x{m['code_offset']:x})" for dex, m, _ in hits)
            sys.exit(f'签名器候选 {len(hits)} 个，无法唯一确定：\n{listing}\n'
                     '请人工确认后收紧 find_signer 的筛选条件。')
    return hits[0]


# ---------------------------------------------------------------------- constants

def _next_value(values, key):
    try:
        index = values.index(key)
    except ValueError:
        return None
    return values[index + 1] if index + 1 < len(values) else None


def signer_constants(seq):
    values = [item['value'] for item in seq]
    marker = values.index(SIGNER_MARKER)

    api_key = None
    for candidate in reversed(values[:marker]):
        if re.fullmatch(r'[0-9A-Fa-f]{20,}', candidate):
            api_key = candidate
            break

    secret = None
    for candidate in values[marker + 1:]:
        if len(candidate) >= 24 and candidate not in HEADER_KEYS:
            if secret is None or len(candidate) > len(secret):
                secret = candidate

    if not api_key or not secret:
        sys.exit('签名器常量提取失败：没在 HmacSHA256 附近找到 api-key 或 HMAC 密钥。')

    return {
        'api_key': api_key,
        'api_secret': secret,
        'accept': _next_value(values, 'accept'),
        'app_version': _next_value(values, 'app-version'),
        'app_build_version': _next_value(values, 'app-build-version'),
        'app_channel': _next_value(values, 'app-channel'),
        'app_platform': _next_value(values, 'app-platform'),
        'user_agent': _next_value(values, 'User-Agent'),
    }


def find_base_url(dexes):
    hosts = []
    for dex in dexes:
        for text in dex.strings:
            if 'picacomic.com' in text and text.startswith(('http://', 'https://')):
                hosts.append(text.rstrip('/'))
    bare = sorted({h for h in hosts if re.fullmatch(r'https?://[A-Za-z0-9.-]+', h)})
    if bare:
        # The API host is the one whose first label says "api"; CDNs and marketing sites are not.
        def score(host):
            label = host.split('://')[1].split('.')[0]
            return ('api' not in label, not host.startswith('https://'), len(host))
        return sorted(bare, key=score)[0]
    if hosts:
        return sorted(hosts, key=len)[0]
    sys.exit('未找到 baseUrl：字符串池里没有 picacomic.com 的 http(s) 地址。')


# ---------------------------------------------------------------------- endpoints

def normalize_path(value):
    """Retrofit paths are relative ('comics/{id}'), sometimes './x' or '/x'; make them comparable."""
    path = value.strip()
    while path.startswith('./'):
        path = path[2:]
    return path.lstrip('/')


def looks_like_path(value):
    """Accept 'comics', 'games/{gameId}' and '.'; reject 'LIBRARY_GROUP' and 'Accept: ...'."""
    if not isinstance(value, str) or not value:
        return False
    if value == '.':
        return True
    if re.search(r'\s', value) or ':' in value:
        return False
    if not re.fullmatch(r'[A-Za-z0-9{}._/\-]+', value):
        return False
    return bool(re.search(r'[/{}]', value)) or bool(re.fullmatch(r'[a-z][a-z0-9._\-]*', value))


def endpoint_rows(dexes):
    """Group method-level annotations by type, then keep the types that behave like Retrofit verbs.

    A verb annotation is reused across many methods and always carries a relative path
    (single segment, 'a/b', '{id}' templates or '.'). Single-use annotations are reported
    separately instead of being silently dropped.
    """
    by_type = {}
    for dex in dexes:
        for method in dex.defined:
            for annotation in method.get('annotations') or []:
                value = (annotation.get('values') or {}).get('value')
                if not looks_like_path(value):
                    continue
                by_type.setdefault(annotation['type'], []).append(
                    {'dex': dex, 'method': method, 'annotation': annotation['type'],
                     'path': normalize_path(value)})
                break

    rows, single_use = [], []
    for annotation_type, items in sorted(by_type.items()):
        (rows if len(items) >= 2 else single_use).extend(items)
    return rows, single_use


def map_verbs(rows, baseline, verb_map):
    by_type = {}
    for row in rows:
        by_type.setdefault(row['annotation'], set()).add(row['path'])

    mapping = dict(verb_map or {})
    known = dict((baseline or {}).get('verb_annotations') or {})
    for annotation_type, paths in by_type.items():
        if annotation_type in mapping:
            continue
        if annotation_type in known:
            mapping[annotation_type] = known[annotation_type]
            continue
        previous = {}
        for endpoint in (baseline or {}).get('endpoints', []):
            previous.setdefault(endpoint['method'], set()).add(endpoint['path'])
        if previous:
            scores = sorted(((len(paths & prev) / max(1, len(paths | prev)), verb)
                             for verb, prev in previous.items()), reverse=True)
            if scores[0][0] >= 0.34:
                mapping[annotation_type] = scores[0][1]
                continue
        if annotation_type in ARCHIVE_VERB_MAP and not baseline:
            mapping[annotation_type] = ARCHIVE_VERB_MAP[annotation_type]
            continue
        sys.exit(f'无法判断注解 {annotation_type}（{len(paths)} 个路径）对应的 HTTP 方法：'
                 f'与基线路径重叠过低。用 --verb-map {annotation_type}=GET 手工指定。')

    used = {}
    for annotation_type, verb in mapping.items():
        if verb in used:
            sys.exit(f'两个注解都映射到 {verb}：{used[verb]} 与 {annotation_type}。请用 --verb-map 修正。')
        used[verb] = annotation_type
    return mapping


def endpoint_params(method, param_map):
    params = []
    for slot, annotations in enumerate(method.get('parameter_annotations') or []):
        for annotation in annotations:
            role = param_map.get(annotation['type'], annotation['type'])
            params.append({'slot': slot, 'role': role,
                           'name': (annotation.get('values') or {}).get('value')})
    return params


# ------------------------------------------------------------------------ derived

def signer_fingerprint(dex, method, seq, volatile=()):
    """Structure-only hash: opcodes and constants, with volatile strings masked.

    Offsets and method/type indices move on every rebuild, so they are excluded; the
    app-version/UA strings change on every release, so they are masked. What remains
    changes only when the signing logic itself changes.
    """
    opcodes = '|'.join(ins['opcode'] for ins in dex.instructions(method))
    constants = '|'.join('<volatile>' if item['value'] in volatile else item['value'] for item in seq)
    return hashlib.sha256((opcodes + '#' + constants).encode('utf-8')).hexdigest()


def signature_vector(api_key, secret, path, query, time_value, nonce, method):
    message = path[1:] if path.startswith('/') else path
    if query:
        message += '?' + query
    canonical = (message + str(time_value) + nonce + method + api_key).lower()
    digest = hmac.new(secret.encode('utf-8'), canonical.encode('utf-8'), hashlib.sha256).hexdigest()
    return {'path': path, 'query': query, 'time': time_value, 'nonce': nonce,
            'method': method, 'canonical': canonical, 'signature': digest}


def build(apk=None, verb_map=None):
    import paths as _paths  # local alias keeps the module importable without resolving defaults early
    apk = Path(apk or _paths.APK)
    if not apk.is_file():
        sys.exit(f'找不到样本 APK：{apk}')

    dexes = load_dexes(apk)
    signer_dex, signer_method, seq = find_signer(dexes)
    constants = signer_constants(seq)
    constants['base_url'] = find_base_url(dexes)

    baseline = None
    baseline_file = _paths.ROOT / 'analysis' / 'baseline' / 'protocol.json'
    if baseline_file.is_file():
        baseline = json.loads(baseline_file.read_text(encoding='utf-8'))

    rows, single_use = endpoint_rows(dexes)
    verbs = map_verbs(rows, baseline, verb_map)
    param_map = dict(((baseline or {}).get('param_annotations')) or ARCHIVE_PARAM_MAP)

    endpoints = []
    for row in rows:
        endpoints.append({
            'method': verbs[row['annotation']],
            'path': row['path'],
            'annotation': row['annotation'],
            'class': row['method']['class'],
            'name': row['method']['name'],
            'method_id': row['method']['id'],
            'dex': row['dex'].name,
            'code_offset': row['method']['code_offset'],
            'params': endpoint_params(row['method'], param_map),
        })
    endpoints.sort(key=lambda e: (e['method'], e['path'], e['class'], e['name']))

    vectors = [
        signature_vector(constants['api_key'], constants['api_secret'],
                         ARCHIVE_VECTOR['path'], ARCHIVE_VECTOR['query'], ARCHIVE_VECTOR['time'],
                         ARCHIVE_VECTOR['nonce'], ARCHIVE_VECTOR['method']),
        signature_vector(constants['api_key'], constants['api_secret'],
                         '/comics', 'page=1&s=dd', 1700000001,
                         'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz', 'GET'),
        signature_vector(constants['api_key'], constants['api_secret'],
                         '/comics', 'b=2&a=1', 1700000002,
                         '0123456789abcdefghijklmnopqrstuv', 'GET'),
    ]
    if constants['api_key'] == ARCHIVE_API_KEY and vectors[0]['signature'] != ARCHIVE_VECTOR['signature']:
        sys.exit('提取器自检失败：用存档的 api-key 复算出的签名与离线脚本不一致，'
                 f"得到 {vectors[0]['signature']}，预期 {ARCHIVE_VECTOR['signature']}。")

    headers = []
    for name in HEADER_KEYS:
        if name in DYNAMIC_HEADERS:
            headers.append({'name': name, 'value': None, 'dynamic': True})
        else:
            value = _next_value([i['value'] for i in seq], name)
            if value is not None:
                headers.append({'name': name, 'value': value, 'dynamic': False})

    # Version-shaped constants change on every release; mask them so the fingerprint
    # only moves when the signing logic moves.
    volatile = {value for value in (constants['app_version'], constants['app_build_version'],
                                    constants['user_agent']) if value}

    return {
        'schema': SCHEMA,
        'apk': {'name': apk.name, 'size': apk.stat().st_size, 'sha256': paths.sha256(apk)},
        'extracted_at': datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ'),
        'constants': {key: constants[key] for key in
                      ('base_url', 'api_key', 'api_secret', 'accept', 'app_version',
                       'app_build_version', 'app_channel', 'app_platform', 'user_agent')},
        'headers': headers,
        'signer': {
            'method_id': signer_method['id'],
            'dex': signer_dex.name,
            'code_offset': signer_method['code_offset'],
            'canonical': "lower(path_without_one_leading_slash + ('?'+query if query) + t + nonce + METHOD + api_key)"
                         ' -> HMAC-SHA256(secret) -> lowercase hex',
            'fingerprint': signer_fingerprint(signer_dex, signer_method, seq, volatile),
            'string_sequence': seq,
        },
        'verb_annotations': verbs,
        'param_annotations': param_map,
        'unclassified_annotations': [
            {'annotation': row['annotation'], 'method_id': row['method']['id'], 'value': row['path']}
            for row in single_use
        ],
        'endpoints': endpoints,
        'vectors': vectors,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--apk')
    parser.add_argument('--verb-map', help='形如 Lfn2=GET,Ln94=POST')
    parser.add_argument('--out', help='写到哪个目录（默认 PICA_OUT）')
    args = parser.parse_args()

    verb_map = {}
    for item in (args.verb_map or '').split(','):
        if item.strip():
            key, verb = item.split('=')
            verb_map[key.strip()] = verb.strip()

    protocol = build(args.apk, verb_map)
    out = Path(args.out) if args.out else paths.OUT
    out.mkdir(parents=True, exist_ok=True)
    (out / 'protocol.json').write_text(json.dumps(protocol, ensure_ascii=False, indent=2), encoding='utf-8')
    print(json.dumps({
        'apk': protocol['apk']['name'],
        'endpoints': len(protocol['endpoints']),
        'verbs': {verb: sum(1 for e in protocol['endpoints'] if e['method'] == verb)
                  for verb in sorted({e['method'] for e in protocol['endpoints']})},
        'signer': protocol['signer']['method_id'],
        'output': str(out / 'protocol.json'),
    }, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
