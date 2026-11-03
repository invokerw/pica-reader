"""Controlled live test of the user's authorized PICA account.
Credentials arrive on stdin, never in this file; token stays in process memory.
Only one login attempt and two allowlisted read-only API checks are permitted.
No redirect following, proxy, cookies, TLS bypass, retry or business write.
Only explicitly allowlisted non-sensitive outcome metadata is printed/saved.
"""
from pathlib import Path
import email.utils
import http.client
import json
import secrets
import socket
import ssl
import sys
import time
import uuid

from pica_signature_offline import sign

HOST = 'picaapi.picacomic.com'
TIMEOUT = 25
MAX_BODY = 2 * 1024 * 1024
HERE = Path(__file__).resolve().parent
ALLOWED = {('HEAD', '/'), ('POST', '/auth/sign-in'),
           ('GET', '/users/profile'), ('GET', '/categories')}


def exchange(method, path, headers, body=None):
    if (method, path) not in ALLOWED:
        raise ValueError('Endpoint not permitted in this smoke test')
    # HTTPSConnection uses system DNS and does not consult proxy environment.
    conn = http.client.HTTPSConnection(HOST, timeout=TIMEOUT,
                                      context=ssl.create_default_context())
    started = time.monotonic()
    try:
        conn.connect()  # Default CA and hostname validation before credentials.
        sock = conn.sock
        peer = sock.getpeername()[0]
        tls = sock.version()
        conn.request(method, path, body=body, headers=headers)
        response = conn.getresponse()
        raw = response.read(MAX_BODY + 1)
        safe_headers = {key.lower(): response.getheader(key) for key in
                        ('Content-Type', 'Date', 'Server', 'CF-Ray', 'Retry-After')
                        if response.getheader(key) is not None}
        if len(raw) > MAX_BODY:
            raise ValueError('Response exceeded bounded size')
        meta = {'method': method, 'path': path, 'http_status': response.status,
                'elapsed_ms': round((time.monotonic() - started) * 1000),
                'peer_ip': peer, 'tls': tls, 'headers': safe_headers,
                'response_bytes': len(raw)}
        if 300 <= response.status < 400:
            meta['redirect_blocked'] = True
        try:
            document = json.loads(raw) if raw else None
        except (json.JSONDecodeError, UnicodeDecodeError):
            document = None
        # Never return or print a raw response body in test output.
        return meta, document
    except Exception as exc:
        # No repr/str(exc), URLs with secrets or response dumps in error output.
        return {'method': method, 'path': path, 'error_type': type(exc).__name__,
                'elapsed_ms': round((time.monotonic() - started) * 1000)}, None
    finally:
        conn.close()


def summarize(meta, document):
    if isinstance(document, dict):
        code = document.get('code')
        if isinstance(code, int) and not isinstance(code, bool):
            meta['api_code'] = code
        message = document.get('message')
        # Do not expose arbitrary server text, which may echo account or token.
        meta['message_is_success'] = message == 'success'
        error = document.get('error')
        if isinstance(error, str) and error.isascii() and error.isdigit():
            meta['api_error_code'] = error[:16]
        meta['json_object'] = True
    else:
        meta['json_object'] = False
    meta['business_success'] = (200 <= meta.get('http_status', 0) < 300 and
                                isinstance(document, dict) and
                                document.get('error') != '1023' and
                                (document.get('message') == 'success' or
                                 document.get('code') == 200))
    return meta


def run(account, password):
    nonce = ''.join(secrets.choice('0123456789abcdefghijklmnopqrstuvwxyz')
                    for _ in range(32))
    device_id = uuid.uuid4().hex  # Isolated test identity, not an APK device ID.
    report = {'host': HOST, 'started_at_utc': email.utils.formatdate(usegmt=True),
              'scope': 'One authorized login plus users/profile and categories; no business writes',
              'transport': 'Direct HTTPS, CA+hostname verified; redirects and retries disabled',
              'synthetic_device_identity': True,
              'credentials_saved': False, 'token_saved': False, 'results': []}
    probe, _ = exchange('HEAD', '/', {'User-Agent': 'okhttp/3.8.1'})
    report['transport_probe'] = probe
    if 'error_type' in probe or probe.get('redirect_blocked'):
        report['outcome'] = 'transport_probe_failed_login_not_attempted'
        return report
    # Date supplied by the same verified HTTPS authority; no system-clock change.
    offset = 0.0
    date = probe.get('headers', {}).get('date')
    try:
        if date:
            offset = email.utils.parsedate_to_datetime(date).timestamp() - time.time()
            report['server_clock_delta_seconds'] = round(offset, 1)
    except (ValueError, TypeError, OverflowError):
        date = None
    report['signing_time_source'] = 'HTTPS Date + elapsed time' if date else 'local clock'

    def api_headers(method, path, token=None):
        signed = sign(path, None, int(time.time() + offset), nonce, method)
        headers = {k: signed[k] for k in ('time', 'nonce', 'api-key', 'signature')}
        headers.update({'accept': 'application/vnd.picacomic.com.v1+json',
                        'app-channel': '1', 'app-version': '2.3.1.20241111',
                        'app-uuid': device_id, 'app-platform': 'android',
                        'app-build-version': '20250144',
                        'User-Agent': 'okhttp/3.8.1', 'image-quality': 'medium',
                        'Cache-Control': 'no-cache, no-store',
                        'Content-Type': 'application/json; charset=UTF-8'})
        if token is not None:
            headers['authorization'] = token
        return headers

    body = json.dumps({'email': account.replace('@', ''), 'password': password},
                      ensure_ascii=False, separators=(',', ':')).encode('utf-8')
    meta, doc = exchange('POST', '/auth/sign-in', api_headers('POST', '/auth/sign-in'), body)
    del body
    summarize(meta, doc)
    data = doc.get('data') if isinstance(doc, dict) else None
    token = data.get('token') if isinstance(data, dict) else None
    meta['token_received'] = isinstance(token, str) and bool(token)
    report['results'].append(meta)
    del doc, data
    if not meta['business_success'] or not meta['token_received']:
        token = None
        report['outcome'] = 'login_failed_no_repeat'
        return report
    for path in ('/users/profile', '/categories'):
        meta, doc = exchange('GET', path, api_headers('GET', path, token))
        summarize(meta, doc)
        data = doc.get('data') if isinstance(doc, dict) else None
        if path == '/users/profile':
            meta['profile_object_present'] = isinstance(data, dict) and isinstance(data.get('user'), dict)
        if path == '/categories':
            categories = data.get('categories') if isinstance(data, dict) else None
            if isinstance(categories, list):
                meta['category_count'] = len(categories)
        report['results'].append(meta)
        del doc, data
        if meta.get('http_status') in (401, 403, 429) or 'error_type' in meta:
            report['read_checks_stopped_after_error'] = True
            break
    token = None
    report['outcome'] = ('login_and_read_checks_passed'
                         if len(report['results']) == 3 and
                         all(x['business_success'] for x in report['results'])
                         else 'login_passed_read_check_failed')
    return report


def main():
    credentials = json.loads(sys.stdin.read(4096))
    account, password = credentials.pop('account'), credentials.pop('password')
    if not isinstance(account, str) or not isinstance(password, str):
        raise TypeError('Expected string credentials on stdin')
    try:
        report = run(account, password)
    finally:
        # Python does not guarantee zeroization; process lifetime is the boundary.
        account = password = None
        credentials.clear()
    output = json.dumps(report, ensure_ascii=False, indent=2)
    # Exclusive output: never overwrite previous test evidence.
    stamp = time.strftime('%Y%m%d-%H%M%S', time.gmtime())
    path = HERE / f'api-smoke-result-{stamp}.json'
    with path.open('x', encoding='utf-8') as file:
        file.write(output + '\n')
    print(output)
    print('Sanitized result file:', path.name)


if __name__ == '__main__':
    main()
