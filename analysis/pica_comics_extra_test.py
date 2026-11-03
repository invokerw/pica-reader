"""Extra read-only comics checks: category filter, keyword search, media HEAD.
Reuses the bounded client from pica_comics_test; credentials arrive on stdin and
are never stored. No image bytes are downloaded - only a HEAD on one media URL.
"""
import email.utils
import http.client
import json
import re
import ssl
import sys
import time
from pathlib import Path
from urllib.parse import urlsplit

from pica_comics_test import Client, data_of, docs_of

HERE = Path(__file__).resolve().parent


def head_media(url):
    parts = urlsplit(url)
    if parts.scheme != 'https' or not parts.hostname:
        return {'error_type': 'UnsupportedMediaUrl'}
    conn = http.client.HTTPSConnection(parts.hostname, timeout=20,
                                       context=ssl.create_default_context())
    meta = {'media_host': parts.hostname}
    started = time.monotonic()
    try:
        conn.connect()
        conn.request('HEAD', parts.path + (('?' + parts.query) if parts.query else ''))
        response = conn.getresponse()
        response.read(0)
        meta.update({'http_status': response.status,
                     'elapsed_ms': round((time.monotonic() - started) * 1000),
                     'content_type': (response.getheader('Content-Type') or '')[:64],
                     'content_length': response.getheader('Content-Length')})
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
    report = {'host': 'picaapi.picacomic.com',
              'started_at_utc': email.utils.formatdate(usegmt=True),
              'scope': 'Category filter, keyword search, one media HEAD; no writes',
              'credentials_saved': False, 'token_saved': False,
              'images_downloaded': False, 'steps': []}

    def invoke(method, path, query=None, body=None):
        result, document = client.call(method, path, query, body)
        return result, data_of(document)

    def record(label, meta):
        meta['step'] = label
        report['steps'].append(meta)
        return meta

    login_body = json.dumps({'email': client.account.replace('@', ''),
                             'password': client.password},
                            ensure_ascii=False, separators=(',', ':')).encode('utf-8')
    meta, data = invoke('POST', '/auth/sign-in', body=login_body)
    del login_body
    token = data.get('token') if isinstance(data, dict) else None
    record('sign-in', meta)
    meta['token_received'] = isinstance(token, str) and bool(token)
    if not meta['business_success'] or not token:
        report['outcome'] = 'login_failed'
        return finish(report, client)
    client.token = token
    token = None
    del data

    meta, data = invoke('GET', '/categories')
    record('categories', meta)
    categories = []
    if isinstance(data, dict):
        categories, _ = docs_of(data.get('categories'))
    category_id = next((c.get('_id') for c in categories
                        if isinstance(c, dict) and isinstance(c.get('_id'), str)
                        and c.get('_id')), None)
    meta['category_count'] = len(categories)
    meta['category_sample_keys'] = (sorted(categories[0].keys())[:12]
                                    if categories and isinstance(categories[0], dict) else [])
    meta['filter_id_available'] = bool(category_id)

    if category_id:
        meta, data = invoke('GET', '/comics', 'page=1&c=' + category_id + '&s=dd')
        record('comics-category-filter', meta)
        comics = docs_of(data.get('comics') if isinstance(data, dict) else None)[0]
        meta['item_count'] = len(comics)
        if comics:
            report['filtered_first_comic'] = comics[0].get('_id')

    meta, data = invoke('GET', '/keywords')
    record('keywords', meta)
    keywords = data.get('keywords') if isinstance(data, dict) else None
    keyword = next((k for k in keywords if isinstance(k, str)), None) if isinstance(keywords, list) else None
    meta['keyword_count'] = len(keywords) if isinstance(keywords, list) else 0
    meta['keyword_available'] = bool(keyword)

    if keyword:
        body = json.dumps({'keyword': keyword, 'sort': 'dd'},
                          ensure_ascii=False, separators=(',', ':')).encode('utf-8')
        meta, data = invoke('POST', '/comics/advanced-search', 'page=1', body=body)
        del body
        record('advanced-search', meta)
        comics = docs_of(data.get('comics') if isinstance(data, dict) else None)[0]
        meta['item_count'] = len(comics)

    # Walk to one page's media URL and verify delivery with HEAD only.
    meta, data = invoke('GET', '/comics', 'page=1&s=dd')
    record('comics-for-media', meta)
    comics = docs_of(data.get('comics') if isinstance(data, dict) else None)[0]
    comic_id = comics[0].get('_id') if comics and isinstance(comics[0], dict) else None
    if comic_id:
        meta, data = invoke('GET', '/comics/' + comic_id + '/eps', 'page=1')
        record('comic-eps', meta)
        eps = docs_of(data.get('eps') if isinstance(data, dict) else None)[0]
        order = eps[0].get('order') if eps and isinstance(eps[0], dict) else None
        meta['episode_count'] = len(eps)
        if isinstance(order, int) and not isinstance(order, bool):
            meta, data = invoke('GET', '/comics/' + comic_id + '/order/'
                                     + str(order) + '/pages', 'page=1')
            record('comic-pages', meta)
            pages, _ = docs_of(data.get('pages') if isinstance(data, dict) else None)
            meta['page_count'] = len(pages)
            meta['page_sample_keys'] = sorted(pages[0].keys())[:10] if pages and isinstance(pages[0], dict) else []
            media_url = None
            if pages and isinstance(pages[0], dict):
                media = pages[0].get('media')
                if isinstance(media, dict) and isinstance(media.get('path'), str):
                    path = media['path']
                    if path.startswith('http'):
                        media_url = path
                    elif isinstance(media.get('fileServer'), str):
                        media_url = media['fileServer'].rstrip('/') + '/' + path.lstrip('/')
            if media_url:
                record('media-head', head_media(media_url))

    reads = [s for s in report['steps'] if s['step'] != 'sign-in']
    failed = [s['step'] for s in reads if not s.get('business_success')]
    report['read_count'] = len(reads)
    report['failed_steps'] = failed
    report['outcome'] = 'all_checks_passed' if not failed else 'some_checks_failed'
    return finish(report, client)


def finish(report, client):
    client.token = None
    client.password = None
    # Strip comic ids from recorded paths; only endpoint shapes and counts remain.
    for meta in report['steps']:
        if isinstance(meta.get('path'), str):
            meta['path'] = re.sub(r'/[0-9a-f]{24}', '/{id}', meta['path'])
    report.pop('filtered_first_comic', None)
    output = json.dumps(report, ensure_ascii=False, indent=2)
    stamp = time.strftime('%Y%m%d-%H%M%S', time.gmtime())
    path = HERE / f'api-comics-extra-{stamp}.json'
    with path.open('x', encoding='utf-8') as file:
        file.write(output + '\n')
    print(output)
    print('Sanitized result file:', path.name)


if __name__ == '__main__':
    main()
