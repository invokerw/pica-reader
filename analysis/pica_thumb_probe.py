"""Read-only probe: structure of /comics items and what `thumb` looks like.

Prints structural facts only (types, key names, URL scheme/host/path prefix,
lengths, HTTP status); never the full URL, token, or account.
"""
from __future__ import annotations

import json
import ssl
import sys
import urllib.error
import urllib.parse
import urllib.request

sys.path.insert(0, r'C:\Users\weife\Desktop\work\picacg\analysis')
from pica_comics_test import Client, data_of  # noqa: E402

UA = 'okhttp/3.8.1'


def describe(url: str) -> str:
    parts = urllib.parse.urlsplit(url)
    path = parts.path
    prefix = '/'.join(path.split('/')[:3])
    return (f'scheme={parts.scheme} host={parts.netloc} path_prefix={prefix} '
            f'path_len={len(path)} query={bool(parts.query)} total_len={len(url)}')


def fetch(url: str, headers: dict[str, str] | None = None) -> tuple[int, str, int]:
    ctx = ssl.create_default_context()
    request = urllib.request.Request(url, method='GET', headers=headers or {})
    try:
        with urllib.request.urlopen(request, timeout=20, context=ctx) as response:
            body = response.read(2048)
            return response.status, response.headers.get('content-type', ''), len(body)
    except urllib.error.HTTPError as error:
        return error.code, (error.headers.get('content-type', '') if error.headers else ''), 0
    except Exception as error:  # noqa: BLE001
        return -1, type(error).__name__, 0


def main() -> int:
    credentials = json.loads(sys.stdin.read())
    account = str(credentials['account']).replace('@', '')
    password = str(credentials['password'])
    del credentials

    client = Client(account, password)
    meta, document = client.call('POST', '/auth/sign-in',
                                 body=json.dumps({'email': account, 'password': password}))
    del password
    token = data_of(document).get('token', '') if isinstance(document, dict) else ''
    client.token = token
    print(f"sign-in http={meta.get('http_status')} token_present={bool(token)}")

    meta, document = client.call('GET', '/comics', query='page=1&s=dd')
    data = data_of(document)
    print(f"comics http={meta.get('http_status')} data_keys={sorted(data.keys())}")
    comics = data.get('comics')
    print('comics_container_type=', type(comics).__name__)
    items: list = []
    if isinstance(comics, dict):
        print('comics_keys=', sorted(comics.keys()))
        docs = comics.get('docs')
        print('docs_type=', type(docs).__name__, 'len=', len(docs) if hasattr(docs, '__len__') else '-')
        items = docs if isinstance(docs, list) else []
    elif isinstance(comics, list):
        items = comics
        print('comics_list_len=', len(comics))
    if items:
        first = items[0]
        print('item_type=', type(first).__name__)
        if isinstance(first, dict):
            print('item_keys=', sorted(first.keys()))
            for key in ('thumb', 'cover', 'image', 'title'):
                value = first.get(key)
                if isinstance(value, str):
                    print(f'{key}: type=str len={len(value)} empty={not value}')
                    if value.startswith(('http://', 'https://')):
                        print(f'  {describe(value)}')
                        print('  GET bare   ->', fetch(value))
                        print('  GET with UA->', fetch(value, {'User-Agent': UA}))
                elif isinstance(value, dict):
                    print(f'{key}: type=dict keys={sorted(value.keys())}')
                else:
                    print(f'{key}: type={type(value).__name__}')

    meta, document = client.call('GET', '/comics/random')
    random_data = data_of(document)
    random_items = random_data.get('comics')
    if isinstance(random_items, dict):
        random_items = random_items.get('docs')
    if isinstance(random_items, list) and random_items:
        comic_id = random_items[0].get('_id', '')
        print('random_first_has_id=', bool(comic_id))
        if comic_id:
            meta, document = client.call('GET', f'/comics/{comic_id}/order/1/pages', query='page=1')
            pages = data_of(document).get('pages', {})
            docs = pages.get('docs') if isinstance(pages, dict) else pages
            docs = docs if isinstance(docs, list) else []
            if docs:
                media = docs[0].get('media', {})
                print('media fileServer=', media.get('fileServer'),
                      'path_prefix=', '/'.join(str(media.get('path', '')).split('/')[:2]))
    print('done')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
