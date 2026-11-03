"""One entry point for everything the analysis side does.

    python analysis/pipeline.py static   --apk <APK> --out <DIR>   提取协议 → protocol.json
    python analysis/pipeline.py evidence                            完整 DEX 证据（慢，仅在需要时）
    python analysis/pipeline.py diff     --protocol <DIR>            与基线比较 → REPORT.md
    python analysis/pipeline.py gen                                 生成 Dart 常量与签名向量
    python analysis/pipeline.py accept   --version <ver>            把当前结果固化为新基线
    python analysis/pipeline.py new      --apk <APK> [--version v]  一条命令跑完"分析新版本"
    python analysis/pipeline.py rea      --batch <batch.json>       跑 REA 反编译批次
    python analysis/pipeline.py verify                              自检：从 APK 复现基线且无漂移

`new` 是日常入口：它把 static、diff 串起来，报告写到 analysis/runs/<ver>/REPORT.md，
有 BREAKING 差异时以退出码 2 结束，方便 CI 拦住发布。
"""
from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
from pathlib import Path

import paths

HERE = Path(__file__).resolve().parent
BASELINE = paths.ROOT / 'analysis' / 'baseline' / 'protocol.json'
VERSIONS = paths.ROOT / 'analysis' / 'versions'
RUNS = paths.ROOT / 'analysis' / 'runs'


# --------------------------------------------------------------------------- helpers

def version_of(apk):
    import re
    match = re.search(r'(\d+\.\d+(?:\.\d+)?)', Path(apk).name)
    if not match:
        sys.exit(f'无法从文件名推断版本号：{Path(apk).name}，请用 --version 指定。')
    return match.group(1)


def child_env(apk=None, out=None, version=None):
    env = os.environ.copy()
    if apk:
        env['PICA_APK'] = str(Path(apk).resolve())
    if out:
        env['PICA_OUT'] = str(Path(out).resolve())
    if version:
        env['PICA_VERSION'] = version
    return env


def run_child(script, *args, env=None):
    command = [sys.executable, str(HERE / script), *map(str, args)]
    print(f'> {script} {" ".join(str(a) for a in args)}'.rstrip())
    result = subprocess.run(command, cwd=str(HERE), env=env)
    if result.returncode != 0:
        sys.exit(f'{script} 失败，退出码 {result.returncode}')


def write_protocol(protocol, directory):
    directory = Path(directory)
    directory.mkdir(parents=True, exist_ok=True)
    target = directory / 'protocol.json'
    target.write_text(json.dumps(protocol, ensure_ascii=False, indent=2), encoding='utf-8')
    return target


def print_summary(protocol, target):
    endpoints = protocol['endpoints']
    verbs = {verb: sum(1 for e in endpoints if e['method'] == verb) for verb in sorted({e['method'] for e in endpoints})}
    print(json.dumps({
        'apk': protocol['apk']['name'],
        'endpoints': len(endpoints),
        'verbs': verbs,
        'signer': protocol['signer']['method_id'],
        'output': str(target),
    }, ensure_ascii=False, indent=2))


# --------------------------------------------------------------------------- commands

def cmd_static(args):
    import extract_protocol

    verb_map = {}
    for item in (args.verb_map or '').split(','):
        if item.strip():
            key, verb = item.split('=')
            verb_map[key.strip()] = verb.strip()

    apk = args.apk or paths.APK
    protocol = extract_protocol.build(apk, verb_map)
    target = write_protocol(protocol, args.out or paths.OUT)
    print_summary(protocol, target)
    return 0


def cmd_evidence(args):
    env = child_env(args.apk, args.out, getattr(args, 'version', None))
    run_child('apk_probe.py', env=env)
    run_child('dex_evidence.py', env=env)
    run_child('focused_dex.py', env=env)
    run_child('build_protocol_catalog.py', env=env)
    return 0


def cmd_diff(args):
    import diff_protocol

    argv = []
    if args.baseline:
        argv += ['--baseline', str(args.baseline)]
    if args.protocol:
        argv += ['--protocol', str(Path(args.protocol) / 'protocol.json')]
    if args.out:
        argv += ['--out', str(args.out)]
    return diff_protocol.main(argv)


def cmd_gen(args):
    import gen_dart

    argv = []
    if args.protocol:
        argv += ['--protocol', str(Path(args.protocol) / 'protocol.json')]
    if args.check:
        argv += ['--check']
    return gen_dart.main(argv)


def cmd_accept(args):
    protocol_dir = Path(args.protocol) if args.protocol else Path(paths.OUT)
    protocol_path = protocol_dir / 'protocol.json'
    if not protocol_path.is_file():
        sys.exit(f'没有可固化的结果：{protocol_path}。先运行 `pipeline.py static`。')

    version = args.version or version_of((json.loads(protocol_path.read_text(encoding='utf-8')).get('apk') or {})
                                         .get('name', ''))
    BASELINE.parent.mkdir(parents=True, exist_ok=True)
    if BASELINE.is_file():
        shutil.copy2(BASELINE, BASELINE.with_suffix('.previous.json'))
    shutil.copy2(protocol_path, BASELINE)
    print(f'基线已更新：{BASELINE.relative_to(paths.ROOT).as_posix()}（旧基线备份为 protocol.previous.json）')

    record = VERSIONS / version
    record.mkdir(parents=True, exist_ok=True)
    protocol = json.loads(protocol_path.read_text(encoding='utf-8'))
    apk = protocol.get('apk') or {}
    lines = [
        f"version: {version}",
        f"apk: {apk.get('name')}",
        f"sha256: {apk.get('sha256')}",
        f"size: {apk.get('size')}",
        f"extracted_at: {protocol.get('extracted_at')}",
        f"signer: {protocol['signer']['method_id']}",
        f"signer_fingerprint: {protocol['signer']['fingerprint']}",
        f"endpoints: {len(protocol.get('endpoints') or [])}",
        '',
    ]
    (record / 'sha256.txt').write_text('\n'.join(lines), encoding='utf-8', newline='\n')
    report = protocol_dir / 'REPORT.md'
    if report.is_file():
        shutil.copy2(report, record / 'REPORT.md')
    print(f'版本记录：{(record / "sha256.txt").relative_to(paths.ROOT).as_posix()}')
    print('记得在 analysis/CHANGELOG.md 里补一条记录。')
    return 0


def cmd_new(args):
    apk = Path(args.apk or paths.APK)
    if not apk.is_file():
        sys.exit(f'找不到样本 APK：{apk}')
    version = args.version or version_of(apk)
    out = Path(args.out) if args.out else RUNS / version
    out.mkdir(parents=True, exist_ok=True)

    print(f'== 1/3 提取协议（{apk.name} → {out}）')
    code = cmd_static(argparse.Namespace(apk=str(apk), out=str(out), verb_map=None))
    if code:
        return code

    print('== 2/3 与基线比较')
    code = cmd_diff(argparse.Namespace(baseline=None, protocol=str(out), out=str(out / 'REPORT.md')))

    if args.rea:
        print('== 3/3 REA 反编译（可选，较慢）')
        batches = args.rea_batch or sorted(HERE.glob('rea_batches/*.json'))
        if not batches:
            print('   没有找到批次文件，跳过')
        for batch in batches:
            run_child('rea_batch.mjs', batch, env=child_env(apk, out, version))
    else:
        print('== 3/3 跳过 REA（加 --rea 可补跑）')

    print()
    print(f'报告：{(out / "REPORT.md").relative_to(paths.ROOT).as_posix()}')
    if code == 2:
        print('存在 BREAKING 差异：按报告改代码，再 `pipeline.py gen` 与 `pipeline.py accept`。')
    else:
        print('没有 BREAKING 差异：可运行 `pipeline.py gen` 与 `pipeline.py accept --version '
              f'{version}` 前移基线。')
    return code


def cmd_rea(args):
    batches = [Path(b) for b in args.batch or []]
    if not batches:
        sys.exit('用 --batch 指定至少一个批次文件（例如 analysis/rea_batches/supplement.json）。')
    env = child_env(args.apk, args.out, getattr(args, 'version', None))
    for batch in batches:
        command = ['node', str(HERE / 'rea_batch.mjs'), str(batch.resolve())]
        print(f'> rea_batch.mjs {batch.name}')
        result = subprocess.run(command, cwd=str(HERE), env=env)
        if result.returncode != 0:
            sys.exit(f'REA 批次失败：{batch.name}（退出码 {result.returncode}）')
    return 0


def cmd_verify(args):
    print('== 1/2 从 APK 重新提取并与基线比较')
    out = RUNS / '.verify'
    code = cmd_static(argparse.Namespace(apk=args.apk, out=str(out), verb_map=None))
    if code:
        return code
    code = cmd_diff(argparse.Namespace(baseline=None, protocol=str(out), out=str(out / 'REPORT.md')))
    if code:
        print('基线无法从样本 APK 复现，见上方报告。')
        return code

    print('== 2/2 检查生成的 Dart 文件是否漂移')
    return cmd_gen(argparse.Namespace(protocol=str(out), check=True))


# --------------------------------------------------------------------------- CLI

def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest='command', required=True)

    def add(name, func, help_text):
        item = sub.add_parser(name, help=help_text)
        item.set_defaults(func=func)
        return item

    apk_args = lambda p: p.add_argument('--apk', help='样本 APK；默认读 PICA_APK 或仓库根目录的默认文件名')

    p = add('static', cmd_static, '提取协议常量与接口清单')
    apk_args(p)
    p.add_argument('--out', help='输出目录；默认 PICA_OUT（analysis/）')
    p.add_argument('--verb-map', help='强制指定注解→动词，例如 Lfn2=GET,Ln94=POST')

    p = add('evidence', cmd_evidence, '完整 DEX 证据（apk_probe → dex_evidence → focused_dex → catalog）')
    apk_args(p)
    p.add_argument('--out')

    p = add('diff', cmd_diff, '与基线比较并生成报告')
    p.add_argument('--baseline', help='默认 analysis/baseline/protocol.json')
    p.add_argument('--protocol', help='待比较结果所在目录，默认 PICA_OUT')
    p.add_argument('--out', help='报告路径；默认打印到终端')

    p = add('gen', cmd_gen, '生成 api_config.g.dart 与 signature_vectors.g.dart')
    p.add_argument('--protocol', help='结果所在目录，默认 PICA_OUT')
    p.add_argument('--check', action='store_true', help='只检查漂移，不写文件')

    p = add('accept', cmd_accept, '把当前结果固化为新基线')
    p.add_argument('--version', help='版本号；默认从 APK 文件名推断')
    p.add_argument('--protocol', help='结果所在目录，默认 PICA_OUT')

    p = add('new', cmd_new, '分析新版本 APK：提取 → 比较 → 报告')
    apk_args(p)
    p.add_argument('--version', help='版本号；默认从文件名推断')
    p.add_argument('--out', help='结果目录；默认 analysis/runs/<version>')
    p.add_argument('--rea', action='store_true', help='同时跑 REA 反编译批次')
    p.add_argument('--rea-batch', action='append', help='指定批次文件（可重复）')

    p = add('rea', cmd_rea, '只跑 REA 反编译批次')
    apk_args(p)
    p.add_argument('--out')
    p.add_argument('--batch', action='append', help='批次文件（可重复）')

    p = add('verify', cmd_verify, '自检：从 APK 复现基线、生成文件无漂移')
    apk_args(p)

    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == '__main__':
    sys.exit(main())
