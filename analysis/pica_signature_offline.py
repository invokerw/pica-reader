"""Offline reproduction of this APK's signing formula for research.
No HTTP client, credentials or APK execution. HMAC constants are extracted from
original DEX evidence instead of being retyped. Not server-validated.
Uses ASCII URL/test inputs; Python Unicode lower() is not a substitute for Java
Locale.ROOT in every edge case. Pass the already encoded path/query verbatim.
"""
from pathlib import Path
import hashlib, hmac, json

from paths import OUT

SIGNER = 'Lfg4;->a(Lhe3;)Ls65;'

def signing_constants():
    evidence = json.loads((OUT/'dex_protocol_evidence.json').read_text(encoding='utf-8'))
    method = next(m for m in evidence['interesting_methods'] if m['id']==SIGNER)
    strings = {i['pc']: i['string'] for i in method['instructions'] if 'string' in i}
    assert strings[0x84] == 'HmacSHA256'
    return strings[0x75], strings[0x8e]

def int32(value):
    return (value + 2**31) % 2**32 - 2**31

def sign(encoded_path, encoded_query, epoch_seconds, nonce, method):
    """Return unsigned-input metadata and digest; never sends a request."""
    api_key, secret = signing_constants()
    path = encoded_path[1:] if encoded_path.startswith('/') else encoded_path
    if encoded_query:
        path += '?' + encoded_query
    t = int32(epoch_seconds)
    canonical = (path + str(t) + nonce + method + api_key).lower()
    digest = hmac.new(secret.encode('utf-8'), canonical.encode('utf-8'), hashlib.sha256).hexdigest()
    return {'time': str(t), 'nonce': nonce, 'api-key': api_key,
            'canonical_input': canonical, 'signature': digest}

if __name__ == '__main__':
    # Deterministic local vector; invented nonce/time, no user account or password.
    result = sign('/auth/sign-in', None, 1700000000,
                  '0123456789abcdefghijklmnopqrstuv', 'POST')
    assert len(result['signature']) == 64
    assert result['signature'] == result['signature'].lower()
    assert sign('/auth/sign-in', '', 1700000000,
                result['nonce'], 'POST')['signature'] == result['signature']
    assert sign('/comics', 'page=1&s=dd', 1700000000,
                result['nonce'], 'GET')['signature'] != sign('/comics', 's=dd&page=1', 1700000000,
                result['nonce'], 'GET')['signature']
    assert int32(2147483648) == -2147483648
    print(json.dumps({'note':'Offline formula vector only; NOT APK execution or server validation',
                      **result}, ensure_ascii=False, indent=2))
