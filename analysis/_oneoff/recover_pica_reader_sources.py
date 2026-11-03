"""Rebuild the Dart sources that a PowerShell Get-Content/Set-Content round trip
mangled (it decoded UTF-8 bytes as GBK, losing characters).

The original file bodies are still recorded verbatim in the decompressed
transcript dump, so this script replays every write/edit tool call it finds
there, in order, for the affected files only, and prints the resulting content
so it can be written back with the ordinary file tools (which always use UTF-8).
"""

from __future__ import annotations

import json
from pathlib import Path

DUMP = Path(
    r"C:\Users\weife\.dsh\profiles\desktop\analysis\pica_reader_original_writes.md"
)
TARGETS = [
    "pica_reader/lib/src/api/models.dart",
    "pica_reader/lib/src/api/api_client.dart",
    "pica_reader/lib/src/ui/widgets/pica_image.dart",
    "pica_reader/lib/src/ui/browse_page.dart",
    "pica_reader/lib/src/ui/rank_page.dart",
    "pica_reader/lib/src/ui/search_page.dart",
    "pica_reader/lib/src/ui/comic_page.dart",
    "pica_reader/lib/src/ui/me_page.dart",
]
OUT = Path(r"C:\Users\weife\Desktop\work\picacg\analysis\pica_reader_recovered")


def iter_calls(text: str):
    decoder = json.JSONDecoder()
    index = 0
    while True:
        start = text.find('{"content":', index)
        alt = text.find('{"file_path":', index)
        if start < 0:
            start = alt
        elif alt >= 0:
            start = min(start, alt)
        if start < 0:
            return
        try:
            obj, end = decoder.raw_decode(text, start)
        except json.JSONDecodeError:
            index = start + 1
            continue
        if isinstance(obj, dict) and "file_path" in obj:
            yield obj
        index = end


def main() -> None:
    text = DUMP.read_text(encoding="utf-8")
    state: dict[str, str] = {}
    applied: dict[str, int] = {}
    for call in iter_calls(text):
        path = str(call.get("file_path", "")).replace("\\", "/")
        if path not in TARGETS:
            continue
        if "content" in call:
            state[path] = call["content"]
            applied[path] = applied.get(path, 0) + 1
        elif "old_string" in call and "new_string" in call:
            current = state.get(path, "")
            old = call["old_string"]
            if old and old in current:
                state[path] = current.replace(old, call["new_string"], 1)
                applied[path] = applied.get(path, 0) + 1

    for path in TARGETS:
        body = state.get(path)
        if body is None:
            print(f"MISSING  {path}")
            continue
        target = OUT / Path(path).name
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(body, encoding="utf-8", newline="\n")
        print(f"ok  {applied.get(path, 0):2d} calls  {len(body):6d} chars  {target}")


if __name__ == "__main__":
    main()
