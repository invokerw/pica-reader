"""Read-only comics sweep against the user's authorized PICA account.
Credentials arrive on stdin; the token stays in process memory and is never stored.
Only GET reads (plus one sign-in) on an explicit allowlist. No likes, favourites,
comments, punch-in or other business writes. Image bytes are never downloaded.
Output is sanitized metadata only: counts, status codes and field names.
"""
from pathlib import Path
import email.utils
import http.client
import json
import secrets
import ssl
import sys
import time
import uuid

from pica_signature_offline import sign

HOST = 'picaapi.picacomic.com'
TIMEOUT = 25
MAX_BODY = 4 * 1024 * 1024
HERE = Path(__file__).resolve().parent
PAUSE = 0.35


class Client:
    def __init__(self, account, password):
        self.account = account
        self.password = password
        self.nonce = ''.join(secrets.choice('0123456789abcdefghijklmnopqrstuvwxyz')
                             for _ in range(32))
        self.device = uuid.uuid4().hex
        self.token = None
        self.offset = 0.0

    def call(self, method, path, query=None, body=None, authorized=True):
        target = path + (('?' + query) if query else '')
        signed = sign(path, query, int(time.time() + self.offset), self.nonce, method)
        headers = {k: signed[k] for k in ('time', 'nonce', 'api-key', 'signature')}
        headers.update({'accept': 'application/vnd.picacomic.com.v1+json',
                        'app-channel': '1', 'app-version': '2.3.1.20241111',
                        'app-uuid': self.device, 'app-platform': 'android',
                        'app-build-version': '20250144',
                        'User-Agent': 'okhttp/3.8.1', 'image-quality': 'medium',
                        'Cache-Control': 'no-cache, no-store',
                        'Content-Type': 'application/json; charset=UTF-8'})
        if authorized and self.token:
            headers['authorization'] = self.token
        conn = http.client.HTTPSConnection(HOST, timeout=TIMEOUT,
                                           context=ssl.create_default_context())
        started = time.monotonic()
        meta = {'method': method, 'path': path, 'query': query}
        document = None
        try:
            conn.connect()
            if conn.sock.version() != 'TLSv1.3':
                meta['tls'] = conn.sock.version()
            conn.request(method, target, body=body, headers=headers)
            response = conn.getresponse()
            raw = response.read(MAX_BODY + 1)
            meta['http_status'] = response.status
            meta['elapsed_ms'] = round((time.monotonic() - started) * 1000)
            meta['response_bytes'] = min(len(raw), MAX_BODY)
            date = response.getheader('Date')
            if date and not self.offset:
                try:
                    self.offset = email.utils.parsedate_to_datetime(date).timestamp() - time.time()
                except (ValueError, TypeError, OverflowError):
                    pass
            if 300 <= response.status < 400:
                meta['redirect_blocked'] = True
            if len(raw) <= MAX_BODY and raw:
                try:
                    document = json.loads(raw)
                except (json.JSONDecodeError, UnicodeDecodeError):
                    document = None
        except Exception as exc:
            meta['error_type'] = type(exc).__name__
        finally:
            conn.close()
        if isinstance(document, dict):
            code = document.get('code')
            meta['api_code'] = code if isinstance(code, int) and not isinstance(code, bool) else None
            meta['message_is_success'] = document.get('message') == 'success'
            error = document.get('error')
            if isinstance(error, str) and error.isascii() and error.isdigit():
                meta['api_error_code'] = error[:16]
            meta['business_success'] = (meta.get('http_status') == 200 and code == 200
                                        and document.get('message') == 'success')
        else:
            meta['business_success'] = False
        time.sleep(PAUSE)
        return meta, document


def data_of(document):
    return document.get('data') if isinstance(document, dict) else None


def docs_of(value):
    """List endpoints nest items under docs; leaderboard/random return plain lists."""
    if isinstance(value, list):
        return value, None
    if isinstance(value, dict) and isinstance(value.get('docs'), list):
        return value['docs'], value
    return [], None


def items(data, key):
    value = data.get(key) if isinstance(data, dict) else None
    return docs_of(value)[0]


def main():
    credentials = json.loads(sys.stdin.read(4096))
    account, password = credentials.pop('account'), credentials.pop('password')
    credentials.clear()
    client = Client(account, password)
    account = password = None
    report = {'host': HOST, 'started_at_utc': email.utils.formatdate(usegmt=True),
              'scope': 'Read-only comics endpoints; no likes/favourites/comments',
              'credentials_saved': False, 'token_saved': False, 'images_downloaded': False,
              'steps': []}

    def step(label, method, path, query=None, body=None, extract=None):
        meta, document = client.call(method, path, query, body)
        meta['step'] = label
        data = data_of(document)
        if extract:
            try:
                extract(meta, data)
            except (KeyError, TypeError, AttributeError, ValueError):
                meta['extract_failed'] = True
        if isinstance(data, dict):
            meta['data_keys'] = sorted(k for k in data if isinstance(k, str))[:16]
        report['steps'].append(meta)
        return meta, data

    probe, _ = client.call('HEAD', '/')
    probe['step'] = 'probe'
    report['steps'].append(probe)
    signin_body = json.dumps({'email': client.account.replace('@', ''),
                              'password': client.password},
                             ensure_ascii=False, separators=(',', ':')).encode('utf-8')
    meta, data = step('sign-in', 'POST', '/auth/sign-in', body=signin_body)
    del signin_body
    token = data.get('token') if isinstance(data, dict) else None
    meta['token_received'] = isinstance(token, str) and bool(token)
    if not meta['business_success'] or not token:
        report['outcome'] = 'login_failed_no_comics_calls'
        return finish(report, client)
    client.token = token
    token = None
    del data

    def list_meta(key):
        def extract(meta, data):
            value = data.get(key) if isinstance(data, dict) else None
            docs, holder = docs_of(value)
            meta['item_count'] = len(docs)
            if isinstance(holder, dict):
                for field in ('total', 'limit', 'page'):
                    number = holder.get(field)
                    if isinstance(number, int) and not isinstance(number, bool):
                        meta[field] = number
            meta['item_keys'] = sorted(docs[0].keys())[:20] if docs and isinstance(docs[0], dict) else []
        return extract

    first_comic = {}

    def grab_comic(meta, data):
        list_meta('comics')(meta, data)
        docs = items(data, 'comics')
        if docs and isinstance(docs[0], dict):
            first_comic['id'] = docs[0].get('_id')
            first_comic['has_eps'] = isinstance(docs[0].get('epsCount'), int)
    # Browsing / ranking lists.
    step('comics-page1-default', 'GET', '/comics', 'page=1&s=dd', extract=grab_comic)
    step('comics-page2-default', 'GET', '/comics', 'page=2&s=dd', extract=list_meta('comics'))
    step('comics-page1-views', 'GET', '/comics', 'page=1&s=vd', extract=list_meta('comics'))
    for timeframe in ('H24', 'D7', 'D30'):
        step('leaderboard-' + timeframe, 'GET', '/comics/leaderboard',
             'tt=' + timeframe + '&ct=VC', extract=list_meta('comics'))
    step('comics-random', 'GET', '/comics/random', extract=list_meta('comics'))

    comic_id = first_comic.get('id')
    report['comic_id_available'] = bool(comic_id)
    if comic_id:
        step('comic-detail', 'GET', '/comics/' + comic_id,
             extract=lambda m, d: m.update({'comic_present': isinstance(d.get('comic'), dict)}))
        order = {}

        def grab_eps(meta, data):
            eps = items(data, 'eps')
            meta['episode_count'] = len(eps)
            if eps and isinstance(eps[0], dict):
                meta['episode_keys'] = sorted(eps[0].keys())[:20]
                number = eps[0].get('order')
                if isinstance(number, int) and not isinstance(number, bool):
                    order['value'] = number

        step('comic-eps', 'GET', '/comics/' + comic_id + '/eps', 'page=1', extract=grab_eps)
        if 'value' in order:
            def grab_pages(meta, data):
                pages = items(data, 'pages')
                meta['page_count'] = len(pages)
                if pages and isinstance(pages[0], dict):
                    meta['page_keys'] = sorted(pages[0].keys())[:20]
                    media = pages[0].get('media')
                    if isinstance(media, dict):
                        meta['media_keys'] = sorted(media.keys())[:12]
                        server = media.get('fileServer') or media.get('path')
                        if isinstance(server, str):
                            meta['media_host'] = (server.split('/')[2]
                                                  if server.startswith('http') else 'relative')
                        meta['media_path_present'] = bool(media.get('path'))
            step('comic-pages', 'GET', '/comics/' + comic_id + '/order/' + str(order['value']) + '/pages',
                 'page=1', extract=grab_pages)
        else:
            report['steps'].append({'step': 'comic-pages', 'skipped': 'no episode order'})

        def grab_comments(meta, data):
            docs, holder = docs_of(data.get('comments') if isinstance(data, dict) else None)
            meta['comment_count'] = len(docs)
            meta['top_comment_count'] = len(items(data, 'topComments'))
            if isinstance(holder, dict) and isinstance(holder.get('total'), int):
                meta['comment_total'] = holder['total']
        step('comic-comments', 'GET', '/comics/' + comic_id + '/comments', 'page=1',
             extract=grab_comments)

    # App content lists.
    step('collections', 'GET', '/collections', extract=list_meta('collections'))
    step('banners', 'GET', '/banners', extract=list_meta('banners'))
    step('keywords', 'GET', '/keywords', extract=list_meta('keywords'))
    step('announcements', 'GET', '/announcements', 'page=1&platform=android',
         extract=list_meta('announcements'))

    reads = [s for s in report['steps'] if s['step'] not in ('probe', 'sign-in')]
    failed = [s['step'] for s in reads if not s.get('business_success')]
    report['read_count'] = len(reads)
    report['failed_steps'] = failed
    report['outcome'] = ('all_reads_passed' if not failed
                         else 'some_reads_failed')
    return finish(report, client)


def finish(report, client):
    client.token = None
    client.password = None
    output = json.dumps(report, ensure_ascii=False, indent=2)
    stamp = time.strftime('%Y%m%d-%H%M%S', time.gmtime())
    path = HERE / f'api-comics-result-{stamp}.json'
    with path.open('x', encoding='utf-8') as file:
        file.write(output + '\n')
    print(output)
    print('Sanitized result file:', path.name)


if __name__ == '__main__':
    main()
