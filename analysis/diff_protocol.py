"""Compare a freshly extracted protocol.json against the committed baseline.

Every difference gets a level and a concrete next action, so that "the app updated"
turns into a short to-do list instead of a re-analysis project:

    BREAKING   the reader will stop working until code changes  (exit code 2)
    ADDITIVE   new capability, nothing breaks                   (exit code 0)
    COSMETIC   version strings only, no code change needed      (exit code 0)
    INFO       annotation classes were renamed by R8, harmless  (exit code 0)

    python diff_protocol.py [--baseline PATH] [--protocol PATH] [--out REPORT.md]
"""
from __future__ import annotations

import argparse
import json
import sys
from collections import Counter
from pathlib import Path

import paths

BREAKING_KEYS = ('base_url', 'api_key', 'api_secret')
CONSTANT_LABELS = {
    'base_url': 'baseUrl',
    'api_key': 'api-key',
    'api_secret': 'HMAC 密钥',
    'accept': 'Accept',
    'app_version': 'app-version',
    'app_build_version': 'app-build-version',
    'app_channel': 'app-channel',
    'app_platform': 'app-platform',
    'user_agent': 'User-Agent',
}
CONSTANT_ACTIONS = {
    'base_url': '`pipeline.py gen` 重新生成 api_config.g.dart，并核对 api_client 的路径拼接',
    'api_key': '`pipeline.py gen` 重新生成 api_config.g.dart（签名头里的 api-key）',
    'api_secret': '`pipeline.py gen` 重新生成 api_config.g.dart（HMAC 密钥）',
    'accept': '`pipeline.py gen` 重新生成 api_config.g.dart（Accept 头）',
    'app_version': '`pipeline.py gen` 重新生成 api_config.g.dart；逻辑不用改',
    'app_build_version': '`pipeline.py gen` 重新生成 api_config.g.dart；逻辑不用改',
    'app_channel': '`pipeline.py gen` 重新生成 api_config.g.dart；逻辑不用改',
    'app_platform': '`pipeline.py gen` 重新生成 api_config.g.dart；逻辑不用改',
    'user_agent': '`pipeline.py gen` 重新生成 api_config.g.dart；逻辑不用改',
}
ORDER = ['BREAKING', 'ADDITIVE', 'COSMETIC', 'INFO']


def load(path):
    with open(path, encoding='utf-8') as handle:
        return json.load(handle)


def code(value):
    """Inline-code a value for a Markdown table cell; secrets contain backticks and pipes."""
    text = '' if value is None else str(value)
    if text == '':
        return '*(空)*'
    text = text.replace('|', '\\|')
    if '`' in text:
        return f'`` {text} ``'
    return f'`{text}`'


def volatile_of(protocol):
    constants = protocol.get('constants') or {}
    return {constants.get(k) for k in ('app_version', 'app_build_version', 'user_agent') if constants.get(k)}


def masked_sequence(sequence, volatile):
    return ['<volatile>' if item.get('value') in volatile else item.get('value')
            for item in (sequence or [])]


def diff_constants(old, new):
    rows = []
    for key, label in CONSTANT_LABELS.items():
        before = (old.get('constants') or {}).get(key)
        after = (new.get('constants') or {}).get(key)
        if before == after:
            continue
        rows.append({'area': '常量', 'item': label, 'old': before, 'new': after,
                     'level': 'BREAKING' if key in BREAKING_KEYS else 'COSMETIC',
                     'action': CONSTANT_ACTIONS[key]})
    return rows


def diff_headers(old, new):
    rows = []
    before = {h['name']: h.get('value') for h in old.get('headers') or []}
    after = {h['name']: h.get('value') for h in new.get('headers') or []}
    for name in after:
        if name not in before:
            rows.append({'area': '请求头', 'item': name, 'old': None, 'new': after[name],
                         'level': 'ADDITIVE' if after[name] else 'BREAKING',
                         'action': '新增请求头：在 api_client 里补上，值见右列'})
        elif before[name] != after[name]:
            rows.append({'area': '请求头', 'item': name, 'old': before[name], 'new': after[name],
                         'level': 'BREAKING' if name == 'accept' else 'COSMETIC',
                         'action': CONSTANT_ACTIONS.get(name.replace('-', '_'), '对照上表更新 api_config')})
    for name in before:
        if name not in after:
            rows.append({'area': '请求头', 'item': name, 'old': before[name], 'new': None,
                         'level': 'BREAKING',
                         'action': '请求头消失：确认服务端是否已不再要求，再决定是否从 api_client 删除'})
    return rows


def diff_signer(old, new):
    rows = []
    old_signer = old.get('signer') or {}
    new_signer = new.get('signer') or {}
    if old_signer.get('fingerprint') != new_signer.get('fingerprint'):
        rows.append({'area': '签名器', 'item': 'signer fingerprint',
                     'old': old_signer.get('fingerprint'), 'new': new_signer.get('fingerprint'),
                     'level': 'BREAKING',
                     'action': '签名逻辑变了：对照下方常量差异改 signer.dart，再用 `pipeline.py gen` 更新向量'})

    # Mask version-shaped values from both sides: on the baseline they are the old
    # version, on the new extraction the new one, and neither is a real change.
    volatile = volatile_of(old) | volatile_of(new)
    before = masked_sequence(old_signer.get('string_sequence'), volatile)
    after = masked_sequence(new_signer.get('string_sequence'), volatile)
    before_set, after_set = Counter(before), Counter(after)
    for value in (after_set - before_set):
        rows.append({'area': '签名器', 'item': '新增字符串常量', 'old': None, 'new': value,
                     'level': 'ADDITIVE',
                     'action': '确认是新请求头/新参数；若是，按需在 api_client 中补上'})
    for value in (before_set - after_set):
        rows.append({'area': '签名器', 'item': '移除字符串常量', 'old': value, 'new': None,
                     'level': 'BREAKING',
                     'action': '参与签名的字符串消失：必须重读签名逻辑，不要只看常量表'})
    if before != after and before_set == after_set:
        rows.append({'area': '签名器', 'item': '字符串顺序', 'old': ' | '.join(before),
                     'new': ' | '.join(after), 'level': 'BREAKING',
                     'action': '常量集合没变但拼接顺序变了：修改 signer.dart 的拼接顺序'})
    return rows


def diff_endpoints(old, new):
    rows = []
    before = Counter((e.get('method'), e.get('path')) for e in old.get('endpoints') or [])
    after = Counter((e.get('method'), e.get('path')) for e in new.get('endpoints') or [])
    for (method, path), count in sorted((after - before).items()):
        rows.append({'area': '接口', 'item': f'{method} /{path}', 'old': None, 'new': f'新增 ×{count}',
                     'level': 'ADDITIVE', 'action': '新接口：需要的话在 api_client 里加一个方法'})
    for (method, path), count in sorted((before - after).items()):
        rows.append({'area': '接口', 'item': f'{method} /{path}', 'old': f'存在 ×{count}', 'new': None,
                     'level': 'BREAKING', 'action': '接口消失：删掉对应 api_client 方法与 UI 入口'})
    return rows


def diff_annotations(old, new):
    rows = []
    before = old.get('verb_annotations') or {}
    after = new.get('verb_annotations') or {}
    if before != after:
        rows.append({'area': '注解', 'item': 'Retrofit 动词注解类',
                     'old': ', '.join(f'{k} {v}' for k, v in before.items()),
                     'new': ', '.join(f'{k} {v}' for k, v in after.items()),
                     'level': 'INFO', 'action': 'R8 重命名了注解类；提取器已按路径自动对应，无需改动'})
    return rows


def diff_vectors(old, new):
    rows = []
    before = {(v['path'], v.get('query'), v['time'], v['nonce'], v['method']): v['signature']
              for v in old.get('vectors') or []}
    after = {(v['path'], v.get('query'), v['time'], v['nonce'], v['method']): v['signature']
             for v in new.get('vectors') or []}
    for key in sorted(set(before) & set(after)):
        if before[key] != after[key]:
            rows.append({'area': '签名向量', 'item': f'{key[4]} {key[0]}',
                         'old': before[key], 'new': after[key], 'level': 'BREAKING',
                         'action': '相同输入签名不同：签名算法已改，Dart 侧测试会失败'})
    return rows


def compare(old, new):
    rows = []
    rows += diff_constants(old, new)
    rows += diff_headers(old, new)
    rows += diff_signer(old, new)
    rows += diff_endpoints(old, new)
    rows += diff_annotations(old, new)
    rows += diff_vectors(old, new)
    return rows


def summarize(rows):
    return {level: sum(1 for row in rows if row['level'] == level) for level in ORDER}


def render(old, new, rows, header='协议差异报告'):
    counts = summarize(rows)
    old_apk, new_apk = (old.get('apk') or {}), (new.get('apk') or {})
    lines = [f'# {header}', '']
    lines += ['| | 基线 | 新样本 |', '| --- | --- | --- |',
              f"| 文件 | {code(old_apk.get('name'))} | {code(new_apk.get('name'))} |",
              f"| SHA256 | {code(old_apk.get('sha256'))} | {code(new_apk.get('sha256'))} |",
              f"| 提取时间 | {code(old.get('extracted_at'))} | {code(new.get('extracted_at'))} |"]
    lines += ['', f"**结论：BREAKING {counts['BREAKING']} · ADDITIVE {counts['ADDITIVE']} · "
                  f"COSMETIC {counts['COSMETIC']} · INFO {counts['INFO']}**", '']

    if not rows:
        lines += ['协议与基线完全一致，阅读器不需要改动。', '']
        return '\n'.join(lines)

    if counts['BREAKING']:
        lines += ['> 存在 BREAKING 差异：在改完代码并重新 `pipeline.py gen` 之前，不要发布构建。', '']

    lines += ['| # | 区域 | 项 | 基线 | 新 | 等级 | 处置 |', '| --- | --- | --- | --- | --- | --- | --- |']
    for index, row in enumerate(rows, start=1):
        lines.append(f"| {index} | {row['area']} | {code(row['item'])} | {code(row['old'])} | "
                     f"{code(row['new'])} | {row['level']} | {row['action']} |")

    breaking = [row for row in rows if row['level'] == 'BREAKING']
    if breaking:
        lines += ['', '## 必须先做的事', '']
        for index, row in enumerate(breaking, start=1):
            lines.append(f"{index}. {row['item']} —— {row['action']}")
    lines += ['', '## 收尾', '',
              '```powershell',
              'python analysis/pipeline.py gen      # 重新生成 api_config.g.dart 与签名向量',
              'cmd /c \'tools\\flutter.cmd test\'    # 向量测试必须全绿',
              'python analysis/pipeline.py accept --version <新版本号>   # 基线前移',
              '```', '']
    return '\n'.join(lines)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--baseline', default=str(paths.ROOT / 'analysis' / 'baseline' / 'protocol.json'))
    parser.add_argument('--protocol', default=str(Path(paths.OUT) / 'protocol.json'))
    parser.add_argument('--out', help='把报告写到这个文件；默认打印到 stdout')
    args = parser.parse_args(argv)

    baseline_path, protocol_path = Path(args.baseline), Path(args.protocol)
    if not baseline_path.is_file():
        sys.exit(f'没有基线：{baseline_path}。首次运行请用 `pipeline.py accept` 把当前结果固化为基线。')
    if not protocol_path.is_file():
        sys.exit(f'没有待比较的结果：{protocol_path}。先运行 `pipeline.py static`。')

    old, new = load(baseline_path), load(protocol_path)
    rows = compare(old, new)
    report = render(old, new, rows)

    if args.out:
        Path(args.out).write_text(report, encoding='utf-8', newline='\n')
        print(f"报告：{args.out}")
    else:
        print(report)

    counts = summarize(rows)
    print(f"BREAKING={counts['BREAKING']} ADDITIVE={counts['ADDITIVE']} "
          f"COSMETIC={counts['COSMETIC']} INFO={counts['INFO']}")
    return 2 if counts['BREAKING'] else 0


if __name__ == '__main__':
    sys.exit(main())
