import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'api_config.dart';

/// The PICA request signature.
///
/// Recovered from `PicaAuthInterceptor` (classes3.dex, Lfg4;->a):
///
///   message   = pathWithoutOneLeadingSlash
///               + ('?' + encodedQuery if the query is not empty)
///               + time + nonce + method + apiKey
///   signature = lowercaseHex(HMAC-SHA256(apiSecret, utf8(lowercase(message))))
///
/// `time` is an int32 of epoch seconds, which is why it is truncated below.
class Signer {
  Signer._();

  static int nowSeconds() =>
      (DateTime.now().millisecondsSinceEpoch ~/ 1000).toSigned(32);

  static String sign({
    required String path,
    String? query,
    required int time,
    required String nonce,
    required String method,
  }) {
    final buffer = StringBuffer();
    buffer.write(path.startsWith('/') ? path.substring(1) : path);
    if (query != null && query.isNotEmpty) {
      buffer.write('?');
      buffer.write(query);
    }
    buffer
      ..write(time)
      ..write(nonce)
      ..write(method)
      ..write(ApiConfig.apiKey);

    final message = buffer.toString().toLowerCase();
    final digest = Hmac(sha256, utf8.encode(ApiConfig.apiSecret))
        .convert(utf8.encode(message));
    return digest.toString();
  }

  /// PICA removes every `@` from the account before signing in; the same
  /// normalization must be used for the request body.
  static String normalizeAccount(String account) => account.replaceAll('@', '');
}
