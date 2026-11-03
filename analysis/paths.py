"""样本 APK 与输出目录的统一解析。

优先级：环境变量 > 仓库内默认值。默认值保持 2.6.73 的存档布局，
所以老命令（不带任何环境变量）依然按原样工作。

    PICA_APK      分析哪个 APK      默认 <repo>/picacg-v2.6.73.apk
    PICA_OUT      证据写到哪里      默认 <repo>/analysis
    PICA_VERSION  覆盖版本号        默认从 APK 文件名解析

复分析新版本时建议把输出指到 runs 目录，避免覆盖存档证据：

    $env:PICA_APK = '..\\picacg-v2.6.80.apk'
    $env:PICA_OUT = 'analysis\\runs\\2.6.80'
"""
from pathlib import Path
import hashlib
import os
import re
import sys

ROOT = Path(__file__).resolve().parent.parent
DEFAULT_APK = ROOT / 'picacg-v2.6.73.apk'
DEFAULT_OUT = Path(__file__).resolve().parent


def _path(env_name, default):
    raw = os.environ.get(env_name, '').strip()
    if not raw:
        return default
    path = Path(raw).expanduser()
    return path if path.is_absolute() else (ROOT / path)


APK = _path('PICA_APK', DEFAULT_APK)
OUT = _path('PICA_OUT', DEFAULT_OUT)
OUT.mkdir(parents=True, exist_ok=True)


def _version_from_name(stem):
    match = re.search(r'(\d+\.\d+(?:\.\d+)?)', stem)
    return match.group(1) if match else ''


VERSION = os.environ.get('PICA_VERSION', '').strip() or _version_from_name(APK.stem) or 'unknown'


def relpath(path):
    """写进证据 json 的路径一律相对仓库根，换机器/换盘符都不炸。"""
    try:
        return Path(path).resolve().relative_to(ROOT).as_posix()
    except ValueError:
        return str(path)


def sha256(path=None):
    digest = hashlib.sha256()
    with open(Path(path or APK), 'rb') as handle:
        for chunk in iter(lambda: handle.read(1 << 20), b''):
            digest.update(chunk)
    return digest.hexdigest()


def require_apk():
    """入口脚本先调它，缺样本时给人话而不是 FileNotFoundError 堆栈。"""
    if not APK.is_file():
        sys.exit(f'找不到样本 APK：{APK}\n'
                 f'用环境变量 PICA_APK 指定，或把 APK 放到 {DEFAULT_APK.name} 的位置。')
    return APK
