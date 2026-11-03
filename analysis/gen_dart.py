"""Render the protocol baseline into Dart source files.

Two generated files keep the app and the analysis from drifting apart:

    pica_reader/lib/src/api/api_config.g.dart    constants recovered from the APK
    pica_reader/test/signature_vectors.g.dart    digests computed in Python, asserted in Dart

`api_config.dart` itself becomes a one-line export of the generated file, so nobody can
edit the constants by hand any more. Use `--check` in CI to fail on drift.

    python gen_dart.py [--protocol PATH] [--check]
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

import paths

PACKAGE = 'pica_reader'
CONFIG_PATH = Path(PACKAGE) / 'lib' / 'src' / 'api' / 'api_config.dart'
GENERATED_PATH = Path(PACKAGE) / 'lib' / 'src' / 'api' / 'api_config.g.dart'
VECTORS_PATH = Path(PACKAGE) / 'test' / 'signature_vectors.g.dart'

# App-side choices, not APK data; kept here so the generated class stays complete.
IMAGE_QUALITIES = ['original', 'medium', 'low']
DEFAULT_IMAGE_QUALITY = 'medium'
TIMEOUT_SECONDS = 25


def dart_string(value):
    """Prefer a raw literal: the HMAC secret is full of $ and backslashes."""
    if value is None:
        return 'null'
    text = str(value)
    if "'" not in text and '\\' in text:
        return f"r'{text}'"
    escaped = text.replace('\\', '\\\\').replace("'", "\\'").replace('$', '\\$')
    return f"'{escaped}'"


def dart_list(values):
    return '[' + ', '.join(dart_string(value) for value in values) + ']'


def generated_header(protocol, what):
    apk = protocol.get('apk') or {}
    return (
        '// GENERATED FILE - DO NOT EDIT.\n'
        '//\n'
        f'// {what}\n'
        f"// Source : analysis/baseline/protocol.json\n"
        f"// Sample : {apk.get('name')} (sha256 {apk.get('sha256')})\n"
        f"// Regen  : python analysis/pipeline.py gen\n"
    )


def render_config(protocol):
    constants = protocol.get('constants') or {}
    version = (paths.VERSION if paths.VERSION != 'unknown' else (protocol.get('apk') or {}).get('name', ''))
    lines = [generated_header(protocol, '协议常量，由分析流水线从样本 APK 中提取。'), '']
    lines += [
        '/// Values recovered from the PICA APK and verified against the live API.',
        '///',
        f'/// Sample version: {version}',
        '///',
        '/// The three values below can be overridden at build time, e.g. to point at your',
        '/// own study environment:',
        '///',
        '///   flutter build apk --dart-define=PICA_BASE_URL=... \\',
        '///       --dart-define=PICA_API_KEY=... --dart-define=PICA_API_SECRET=...',
        'class ApiConfig {',
        '  ApiConfig._();',
        '',
        '  static const String baseUrl = String.fromEnvironment(',
        "    'PICA_BASE_URL',",
        f"    defaultValue: {dart_string(constants['base_url'])},",
        '  );',
        '',
        '  /// Public api-key header value.',
        '  static const String apiKey = String.fromEnvironment(',
        "    'PICA_API_KEY',",
        f"    defaultValue: {dart_string(constants['api_key'])},",
        '  );',
        '',
        '  /// HMAC-SHA256 key embedded in PicaAuthInterceptor (constant string).',
        '  ///',
        '  /// Shipping a client secret inside the app is unavoidable for this API: the',
        '  /// server recomputes the signature from the same secret. Treat it as public.',
        '  static const String apiSecret = String.fromEnvironment(',
        "    'PICA_API_SECRET',",
        f"    defaultValue: {dart_string(constants['api_secret'])},",
        '  );',
        '',
        f"  static const String accept = {dart_string(constants['accept'])};",
        f"  static const String appVersion = {dart_string(constants['app_version'])};",
        f"  static const String appBuildVersion = {dart_string(constants['app_build_version'])};",
        f"  static const String appChannel = {dart_string(constants['app_channel'])};",
        f"  static const String appPlatform = {dart_string(constants['app_platform'])};",
        f"  static const String userAgent = {dart_string(constants['user_agent'])};",
        '',
        '  /// Image quality sent as `image-quality`; the client uses `medium` by default.',
        '  /// This is a client-side choice, not a value from the APK.',
        f'  static const List<String> imageQualities = {dart_list(IMAGE_QUALITIES)};',
        f'  static const String defaultImageQuality = {dart_string(DEFAULT_IMAGE_QUALITY)};',
        '',
        f'  static const Duration timeout = Duration(seconds: {TIMEOUT_SECONDS});',
        '}',
        '',
    ]
    return '\n'.join(lines)


def render_vectors(protocol):
    lines = [generated_header(protocol, '由 Python 用同一套常量算出的签名，Dart 侧必须逐个复现。'), '']
    lines += [
        'class SignatureVector {',
        '  const SignatureVector({',
        '    required this.path,',
        '    this.query,',
        '    required this.time,',
        '    required this.nonce,',
        '    required this.method,',
        '    required this.signature,',
        '  });',
        '',
        '  final String path;',
        '  final String? query;',
        '  final int time;',
        '  final String nonce;',
        '  final String method;',
        '  final String signature;',
        '}',
        '',
        'const List<SignatureVector> signatureVectors = [',
    ]
    for vector in protocol.get('vectors') or []:
        lines += [
            '  SignatureVector(',
            f"    path: {dart_string(vector['path'])},",
            f"    query: {dart_string(vector['query'])},",
            f"    time: {int(vector['time'])},",
            f"    nonce: {dart_string(vector['nonce'])},",
            f"    method: {dart_string(vector['method'])},",
            f"    signature: {dart_string(vector['signature'])},",
            '  ),',
        ]
    lines += ['];', '']
    return '\n'.join(lines)


STUB = (
    '/// Protocol constants live in the generated file.\n'
    '///\n'
    '/// Regenerate with `python analysis/pipeline.py gen`; do not edit by hand.\n'
    'library;\n'
    '\n'
    "export 'api_config.g.dart';\n"
)


def render_all(protocol):
    return {
        CONFIG_PATH: STUB,
        GENERATED_PATH: render_config(protocol),
        VECTORS_PATH: render_vectors(protocol),
    }


def write(protocol_path=None, check=False):
    if protocol_path:
        protocol_path = Path(protocol_path)
    else:
        latest = Path(paths.OUT) / 'protocol.json'
        baseline = paths.ROOT / 'analysis' / 'baseline' / 'protocol.json'
        protocol_path = latest if latest.is_file() else baseline
    if not protocol_path.is_file():
        sys.exit(f'没有协议结果：{protocol_path}。先运行 `pipeline.py static`。')
    protocol = json.loads(protocol_path.read_text(encoding='utf-8'))

    stale = []
    for relative, content in render_all(protocol).items():
        target = paths.ROOT / relative
        current = target.read_text(encoding='utf-8') if target.is_file() else None
        if current == content:
            print(f'  一致  {relative.as_posix()}')
            continue
        stale.append(relative)
        if not check:
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_text(content, encoding='utf-8', newline='\n')
            print(f'  写入  {relative.as_posix()}')
        else:
            print(f'  漂移  {relative.as_posix()}', file=sys.stderr)

    if check and stale:
        print('\n生成文件与基线不一致：运行 `python analysis/pipeline.py gen` 后提交。', file=sys.stderr)
        return 1
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--protocol')
    parser.add_argument('--check', action='store_true', help='只检查是否漂移，不写文件')
    args = parser.parse_args(argv)
    return write(args.protocol, check=args.check)


if __name__ == '__main__':
    sys.exit(main())
