"""Build the cover URL the app now builds, then fetch it (read-only)."""
import json
import ssl
import sys
import urllib.error
import urllib.parse
import urllib.request

sys.path.insert(0, r'C:\Users\weife\Desktop\work\picacg\analysis')
from pica_comics_test import Client, data_of  # noqa: E402


def main() -> int:
    credentials = json.loads(sys.stdin.read())
    account = str(credentials['account']).replace('@', '')
    client = Client(account, str(credentials['password']))
    meta, document = client.call(
        'POST', '/auth/sign-in',
        body=json.dumps({'email': account, 'password': str(credentials['password'])}))
    del credentials
    client.token = data_of(document).get('token', '')
    meta, document = client.call('GET', '/comics', query='page=1&s=dd')
    first = data_of(document)['comics']['docs'][0]
    thumb = first['thumb']
    server = thumb['fileServer'].rstrip('/')
    if '/static' not in server:
        server += '/static'
    url = server + '/' + thumb['path'].lstrip('/')
    print('cover_built=', len(url), 'bytes')
    request = urllib.request.Request(url, headers={'User-Agent': 'okhttp/3.8.1'})
    try:
        with urllib.request.urlopen(request, timeout=20,
                                    context=ssl.create_default_context()) as response:
            body = response.read(4096)
            print('status=', response.status,
                  'type=', response.headers.get('content-type'),
                  'bytes_read=', len(body),
                  'final_host=', urllib.parse.urlsplit(response.geturl()).netloc)
    except urllib.error.HTTPError as error:
        print('status=', error.code,
              'type=', error.headers.get('content-type') if error.headers else None)
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
