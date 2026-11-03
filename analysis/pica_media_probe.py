"""Focused probe: category filter from a real comic, and image-host access mode.
Credentials on stdin; no image bytes are stored (HEAD plus a 1-byte range GET).
"""
import email.utils
import http.client
import json
import ssl
import sys
import time
from pathlib import Path
from urllib.parse import urlsplit

from pica_comics_test import Client, docs_of

HERE = Path(__file__).resolve().parent


def probe(method, url, extra_headers=None, byte_range=None):
    parts = urlsplit(url)
    if parts.scheme != 'https' or not parts.hostname:
        return {'error_type': 'UnsupportedMediaUrl'}
    headers = dict(extra_headers or {})
    if byte_range:
        headers['Range'] = byte_range
    conn = http.client.HTTPSConnection(parts.hostname, timeout=20,
                                       context=ssl.create_default_context())
    meta = {'method': method, 'host': parts.hostname,
            'path_segments': len([s for s in parts.path.split('/') if s]),
            'path_prefix': '/'.join([s for s in parts.path.split('/') if s][:2]),
            'extension': (parts.path.rsplit('.', 1)[-1].lower()[:6]
                          if '.' in parts.path.rsplit('/', 1)[-1] else None)}
    started = time.monotonic()
    try:
        conn.connect()
        conn.request(method, parts.path + (('?' + parts.query) if parts.query else ''),
                     headers=headers)
        response = conn.getresponse()
        body = response.read(2) if method == 'GET' else response.read(0)
        meta.update({'http_status': response.status,
                     'elapsed_ms': round((time.monotonic() - started) * 1000),
                     'content_type': (response.getheader('Content-Type') or '')[:64],
                     'bytes_read': len(body)})
        if response.status in (401, 403):
            meta['auth_challenge'] = (response.getheader('WWW-Authenticate') or '')[:40]
    except Exception as exc:
        meta['error_type'] = type(exc).__name__
    finally:
        conn.close()
    return meta


def main():
    credentials = json.loads(sys.stdin.read(4096))
    account, password = credentials.pop('account'), credentials.pop('password')
    credentials.clear()
    client = Client(account, password)
    account = password = None
    report = {'host': 'picaapi.picacomic.com', 'started_at_utc': email.utils.formatdate(usegmt=True),
              'scope': 'Category filter by real comic category; image host access mode',
              'credentials_saved': False, 'token_saved': False,
              'images_downloaded': False, 'steps': []}

    def record(label, meta):
        meta['step'] = label
        report['steps'].append(meta)
        return meta

    body = json.dumps({'email': client.account.replace('@', ''),
                       'password': client.password},
                      ensure_ascii=False, separators=(',', ':')).encode('utf-8')
    meta, document = client.call('POST', '/auth/sign-in', body=body)
    del body
    token = (document.get('data') or {}).get('token') if isinstance(document, dict) else None
    record('sign-in', meta)
    meta['token_received'] = isinstance(token, str) and bool(token)
    if not meta['business_success'] or not token:
        report['outcome'] = 'login_failed'
        return finish(report, client)
    client.token = token

    meta, document = client.call('GET', '/comics', 'page=1&s=dd')
    record('comics', meta)
    data = document.get('data') if isinstance(document, dict) else None
    comics = docs_of(data.get('comics') if isinstance(data, dict) else None)[0]
    meta['item_count'] = len(comics)
    comic = comics[0] if comics and isinstance(comics[0], dict) else None
    comic_id = comic.get('_id') if comic else None
    categories = comic.get('categories') if comic else None
    meta['comic_categories_type'] = type(categories).__name__
    first_category = None
    if isinstance(categories, list) and categories:
        item = categories[0]
        if isinstance(item, dict):
            first_category = item.get('_id') or item.get('id')
            meta['category_item_keys'] = sorted(item.keys())[:10]
        elif isinstance(item, str):
            first_category = item
    meta['comic_category_available'] = bool(first_category)

    if first_category:
        meta, document = client.call('GET', '/comics', 'page=1&c=' + first_category + '&s=dd')
        record('comics-category-filter', meta)
        data = document.get('data') if isinstance(document, dict) else None
        filtered = docs_of(data.get('comics') if isinstance(data, dict) else None)[0]
        meta['item_count'] = len(filtered)

    if comic_id:
        meta, document = client.call('GET', '/comics/' + comic_id + '/eps', 'page=1')
        record('comic-eps', meta)
        data = document.get('data') if isinstance(document, dict) else None
        eps = docs_of(data.get('eps') if isinstance(data, dict) else None)[0]
        orders = [e.get('order') for e in eps if isinstance(e, dict) and isinstance(e.get('order'), int)]
        meta['episode_count'] = len(eps)
        if orders:
            meta, document = client.call('GET', '/comics/' + comic_id + '/order/'
                                         + str(min(orders)) + '/pages', 'page=1')
            record('comic-pages', meta)
            data = document.get('data') if isinstance(document, dict) else None
            pages = docs_of(data.get('pages') if isinstance(data, dict) else None)[0]
            meta['page_count'] = len(pages)
            media_url = None
            if pages and isinstance(pages[0], dict):
                media = pages[0].get('media')
                if isinstance(media, dict):
                    meta['media_keys'] = sorted(media.keys())[:10]
                    path = media.get('path')
                    server = media.get('fileServer')
                    if isinstance(path, str):
                        if path.startswith('http'):
                            media_url = path
                        elif isinstance(server, str):
                            media_url = server.rstrip('/') + '/' + path.lstrip('/')
            if media_url:
                ua = {'User-Agent': 'okhttp/3.8.1'}
                record('media-head-bare', probe('HEAD', media_url))
                record('media-head-ua-referer', probe('HEAD', media_url,
                                                      {**ua, 'Referer': 'https://picaapi.picacomic.com/',
                                                       'Accept': 'image/*'}))
                record('media-head-token', probe('HEAD', media_url,
                                                 {**ua, 'authorization': token,
                                                  'Accept': 'image/*'}))
                record('media-get-range', probe('GET', media_url,
                                                {**ua, 'authorization': token,
                                                 'Referer': 'https://picaapi.picacomic.com/',
                                                 'Accept': 'image/*'},
                                                byte_range='bytes=0-0'))

    reads = [s for s in report['steps'] if s['step'] != 'sign-in']
    failed = [s['step'] for s in reads
              if s.get('http_status') is None or not 200 <= s['http_status'] < 300]
    report['read_count'] = len(reads)
    report['failed_steps'] = failed
    report['outcome'] = 'all_checks_passed' if not failed else 'some_checks_failed'
    return finish(report, client)


def finish(report, client):
    client.token = None
    client.password = None
    output = json.dumps(report, ensure_ascii=False, indent=2)
    stamp = time.strftime('%Y%m%d-%H%M%S', time.gmtime())
    path = HERE / f'api-media-probe-{stamp}.json'
    with path.open('x', encoding='utf-8') as file:
        file.write(output + '\n')
    print(output)
    print('Sanitized result file:', path.name)


if __name__ == '__main__':
    main()
