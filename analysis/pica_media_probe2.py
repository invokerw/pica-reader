"""Corrected probe: category title filter and image URL with the client's /static rule.
The APK builds image URLs as fileServer + ('/static' if missing) + '/' + path
(see Lvz2->c in the static report), so a bare fileServer+path URL is wrong.
"""
import email.utils
import http.client
import json
import ssl
import sys
import time
from pathlib import Path
from urllib.parse import quote, urljoin, urlsplit

from pica_comics_test import Client, docs_of

HERE = Path(__file__).resolve().parent


def image_url(server, path):
    if path.startswith('http'):
        return path
    base = server.rstrip('/')
    if '/static' not in base:
        base += '/static'
    return base + '/' + path.lstrip('/')


def probe(method, url, headers=None, byte_range=None):
    parts = urlsplit(url)
    if parts.scheme != 'https' or not parts.hostname:
        return {'error_type': 'UnsupportedMediaUrl'}, None
    request_headers = dict(headers or {})
    if byte_range:
        request_headers['Range'] = byte_range
    conn = http.client.HTTPSConnection(parts.hostname, timeout=20,
                                       context=ssl.create_default_context())
    segments = [s for s in parts.path.split('/') if s]
    meta = {'method': method, 'host': parts.hostname, 'path_segments': len(segments),
            'path_prefix': '/'.join(segments[:2]),
            'extension': (parts.path.rsplit('.', 1)[-1].lower()[:6]
                          if '.' in segments[-1] else None)}
    started = time.monotonic()
    try:
        conn.connect()
        conn.request(method, parts.path + (('?' + parts.query) if parts.query else ''),
                     headers=request_headers)
        response = conn.getresponse()
        body = response.read(2) if method == 'GET' else response.read(0)
        meta.update({'http_status': response.status,
                     'elapsed_ms': round((time.monotonic() - started) * 1000),
                     'content_type': (response.getheader('Content-Type') or '')[:64],
                     'content_length': response.getheader('Content-Length'),
                     'bytes_read': len(body)})
        location = response.getheader('Location')
        if location:
            target = urlsplit(location if '//' in location else url)
            target_segments = [s for s in target.path.split('/') if s]
            meta['location'] = {'host': target.hostname,
                                'scheme': target.scheme,
                                'path_prefix': '/'.join(target_segments[:2]),
                                'segments': len(target_segments)}
    except Exception as exc:
        meta['error_type'] = type(exc).__name__
        location = None
    finally:
        conn.close()
    return meta, location


def main():
    credentials = json.loads(sys.stdin.read(4096))
    account, password = credentials.pop('account'), credentials.pop('password')
    credentials.clear()
    client = Client(account, password)
    account = password = None
    report = {'host': 'picaapi.picacomic.com', 'started_at_utc': email.utils.formatdate(usegmt=True),
              'scope': 'Category title filter; corrected image URL; headers only',
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
    title = None
    if isinstance(categories, list) and categories:
        first = categories[0]
        if isinstance(first, str):
            title = first
        elif isinstance(first, dict):
            title = first.get('title')
    meta['comic_category_title_available'] = isinstance(title, str) and bool(title)

    if title:
        encoded = quote(title, safe='')
        meta, document = client.call('GET', '/comics', 'page=1&c=' + encoded + '&s=dd')
        record('comics-category-title-filter', meta)
        meta['encoded_category'] = encoded
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
                if isinstance(media, dict) and isinstance(media.get('path'), str):
                    media_url = image_url(media.get('fileServer') or '', media['path'])
            if media_url:
                ua = {'User-Agent': 'okhttp/3.8.1', 'Accept': 'image/*'}
                meta, location = probe('HEAD', media_url, ua)
                record('media-head', meta)
                target = media_url
                if location:
                    target = location if '//' in location else urljoin(media_url, location)
                meta, _ = probe('GET', target, ua, byte_range='bytes=0-0')
                record('media-get-range', meta)

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
    path = HERE / f'api-media-probe2-{stamp}.json'
    with path.open('x', encoding='utf-8') as file:
        file.write(output + '\n')
    print(output)
    print('Sanitized result file:', path.name)


if __name__ == '__main__':
    main()
