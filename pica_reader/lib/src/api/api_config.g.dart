// GENERATED FILE - DO NOT EDIT.
//
// 协议常量，由分析流水线从样本 APK 中提取。
// Source : analysis/baseline/protocol.json
// Sample : picacg-v2.6.73.apk (sha256 68b1a02d634f791a673bd58935208cde8c896a6ea0912fcbf1b946d9a229c06e)
// Regen  : python analysis/pipeline.py gen


/// Values recovered from the PICA APK and verified against the live API.
///
/// Sample version: 2.6.73
///
/// The three values below can be overridden at build time, e.g. to point at your
/// own study environment:
///
///   flutter build apk --dart-define=PICA_BASE_URL=... \
///       --dart-define=PICA_API_KEY=... --dart-define=PICA_API_SECRET=...
class ApiConfig {
  ApiConfig._();

  static const String baseUrl = String.fromEnvironment(
    'PICA_BASE_URL',
    defaultValue: 'https://picaapi.picacomic.com',
  );

  /// Public api-key header value.
  static const String apiKey = String.fromEnvironment(
    'PICA_API_KEY',
    defaultValue: 'C69BAF41DA5ABD1FFEDC6D2FEA56B',
  );

  /// HMAC-SHA256 key embedded in PicaAuthInterceptor (constant string).
  ///
  /// Shipping a client secret inside the app is unavoidable for this API: the
  /// server recomputes the signature from the same secret. Treat it as public.
  static const String apiSecret = String.fromEnvironment(
    'PICA_API_SECRET',
    defaultValue: r'~d}$Q7$eIni=V)9\RK/P.RM4;9[7|@/CA}b~OW!3?EV`:<>M7pddUBL5n|0/*Cn',
  );

  static const String accept = 'application/vnd.picacomic.com.v1+json';
  static const String appVersion = '2.3.1.20241111';
  static const String appBuildVersion = '20250144';
  static const String appChannel = '1';
  static const String appPlatform = 'android';
  static const String userAgent = 'okhttp/3.8.1';

  /// Image quality sent as `image-quality`; the client uses `medium` by default.
  /// This is a client-side choice, not a value from the APK.
  static const List<String> imageQualities = ['original', 'medium', 'low'];
  static const String defaultImageQuality = 'medium';

  static const Duration timeout = Duration(seconds: 25);
}
