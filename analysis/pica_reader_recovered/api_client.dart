import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../storage/app_paths.dart';
import 'api_config.dart';
import 'models.dart';
import 'signer.dart';

/// HTTP client for the PICA API.
///
/// Every request is signed exactly like the APK does it, and the identity
/// values (`nonce`, `app-uuid`) are persisted so they stay stable across runs.
class ApiClient {
  ApiClient({this.onUnauthorized});

  final void Function()? onUnauthorized;

  late final Dio _dio;
  String _nonce = '';
  String _deviceUuid = '';
  String? _token;
  String _imageQuality = ApiConfig.defaultImageQuality;
  bool _initialized = false;

  String? get token => _token;
  String get deviceUuid => _deviceUuid;

  set token(String? value) => _token = value;

  set imageQuality(String value) {
    if (ApiConfig.imageQualities.contains(value)) _imageQuality = value;
  }

  Future<void> init() async {
    if (_initialized) return;
    final stored = await AppPaths.readJson('device.json');
    final nonce = asString(stored['nonce']);
    final uuid = asString(stored['uuid']);
    _nonce = RegExp(r'^[0-9a-z]{32}$').hasMatch(nonce) ? nonce : _randomNonce();
    _deviceUuid =
        RegExp(r'^[0-9a-f]{32}$').hasMatch(uuid) ? uuid : const Uuid().v4().replaceAll('-', '');
    if (stored['nonce'] != _nonce || stored['uuid'] != _deviceUuid) {
      await AppPaths.writeJson('device.json', {'nonce': _nonce, 'uuid': _deviceUuid});
    }

    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.timeout,
      sendTimeout: ApiConfig.timeout,
      receiveTimeout: ApiConfig.timeout,
      contentType: 'application/json; charset=UTF-8',
      responseType: ResponseType.json,
      // PICA reports business errors with 4xx bodies that still carry JSON.
      validateStatus: (status) => status != null && status < 500,
      headers: const {'accept': ApiConfig.accept},
    ));
    _dio.interceptors.add(InterceptorsWrapper(onRequest: _sign));
    _initialized = true;
  }

  static String _randomNonce() {
    const alphabet = '0123456789abcdefghijklmnopqrstuvwxyz';
    final random = Random.secure();
    return String.fromCharCodes(
      List.generate(32, (_) => alphabet.codeUnitAt(random.nextInt(alphabet.length))),
    );
  }

  void _sign(RequestOptions options, RequestInterceptorHandler handler) {
    final uri = options.uri;
    final time = Signer.nowSeconds();
    final signature = Signer.sign(
      path: uri.path,
      query: uri.hasQuery ? uri.query : null,
      time: time,
      nonce: _nonce,
      method: options.method,
    );
    options.headers.addAll({
      'accept': ApiConfig.accept,
      'api-key': ApiConfig.apiKey,
      'app-channel': ApiConfig.appChannel,
      'app-version': ApiConfig.appVersion,
      'app-build-version': ApiConfig.appBuildVersion,
      'app-platform': ApiConfig.appPlatform,
      'app-uuid': _deviceUuid,
      'image-quality': _imageQuality,
      'time': '$time',
      'nonce': _nonce,
      'signature': signature,
      'User-Agent': ApiConfig.userAgent,
    });
    final token = _token;
    if (token != null) {
      // The APK sends the raw token; there is no `Bearer ` prefix.
      options.headers['authorization'] = token;
    }
    handler.next(options);
  }

  static String _queryString(Map<String, String>? query) {
    if (query == null || query.isEmpty) return '';
    return query.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<Object?> _send(
    String method,
    String path, {
    Map<String, String>? query,
    Object? body,
  }) async {
    await init();
    final qs = _queryString(query);
    final target = qs.isEmpty ? path : '$path?$qs';
    final Response<dynamic> response;
    try {
      response = await _dio.request<dynamic>(
        target,
        data: body == null ? null : jsonEncode(body),
        options: Options(method: method),
      );
    } on DioException catch (error) {
      throw ApiException(switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          '网络超时，请稍后重试',
        DioExceptionType.connectionError => '无法连接服务器',
        _ => '网络错误：${error.message ?? error.type.name}',
      });
    }
    return _unwrap(response);
  }

  Object? _unwrap(Response<dynamic> response) {
    final status = response.statusCode ?? 0;
    var document = response.data;
    if (document is String) {
      try {
        document = document.isEmpty ? null : jsonDecode(document);
      } on FormatException {
        document = null;
      }
    }
    final map = asMap(document);

    if (status == 401) {
      onUnauthorized?.call();
      throw AuthException('登录状态已失效，请重新登录');
    }
    if (map.isEmpty) {
      throw ApiException('服务器返回了无法解析的数据 (HTTP $status)');
    }

    final error = asString(map['error']);
    final code = asInt(map['code']);
    final message = asString(map['message']);
    // The APK checks the clock-mismatch error before the success branch.
    if (error == '1023') throw TimeSkewException();
    if (code == 200 && message == 'success') return map['data'];
    throw ApiException(
      message.isEmpty ? '请求失败 (HTTP $status)' : message,
      code: code,
      error: error.isEmpty ? null : error,
    );
  }

  Future<Map<String, dynamic>> _asMapRequest(
    String method,
    String path, {
    Map<String, String>? query,
    Object? body,
  }) async {
    final data = await _send(method, path, query: query, body: body);
    return asMap(data);
  }

  Future<Session> signIn({required String account, required String password}) async {
    final data = await _asMapRequest('POST', '/auth/sign-in', body: {
      'email': Signer.normalizeAccount(account),
      'password': password,
    });
    return Session.fromJson(data);
  }

  Future<UserProfile> profile() async {
    final data = await _asMapRequest('GET', '/users/profile');
    return UserProfile.fromJson(asMap(data['user']));
  }

  Future<Paged<Comic>> comics({
    int page = 1,
    String sort = 'dd',
    String? category,
  }) async {
    final data = await _asMapRequest('GET', '/comics', query: {
      'page': '$page',
      's': sort,
      if (category != null && category.isNotEmpty) 'c': category,
    });
    return Paged.parse<Comic>(data['comics'], Comic.fromJson);
  }

  Future<Paged<Comic>> leaderboard({String timeframe = 'H24', String category = 'VC'}) async {
    final data = await _asMapRequest('GET', '/comics/leaderboard', query: {
      'tt': timeframe,
      'ct': category,
    });
    return Paged.parse<Comic>(data['comics'], Comic.fromJson);
  }

  Future<Paged<Comic>> random() async {
    final data = await _asMapRequest('GET', '/comics/random');
    return Paged.parse<Comic>(data['comics'], Comic.fromJson);
  }

  Future<Paged<Comic>> advancedSearch({
    required String keyword,
    String sort = 'dd',
    int page = 1,
  }) async {
    final data = await _asMapRequest(
      'POST',
      '/comics/advanced-search',
      query: {'page': '$page'},
      body: {'keyword': keyword, 'sort': sort},
    );
    return Paged.parse<Comic>(data['comics'], Comic.fromJson);
  }

  Future<Comic> comic(String id) async {
    final data = await _asMapRequest('GET', '/comics/$id');
    return Comic.fromJson(asMap(data['comic']));
  }

  Future<Paged<Episode>> episodes(String comicId, {int page = 1}) async {
    final data = await _asMapRequest('GET', '/comics/$comicId/eps', query: {'page': '$page'});
    return Paged.parse<Episode>(data['eps'], Episode.fromJson);
  }

  Future<Paged<ComicPage>> chapterPages(
    String comicId,
    int order, {
    int page = 1,
  }) async {
    final data = await _asMapRequest(
      'GET',
      '/comics/$comicId/order/$order/pages',
      query: {'page': '$page'},
    );
    return Paged.parse<ComicPage>(data['pages'], ComicPage.fromJson);
  }

  Future<ChapterComments> comments(String comicId, {int page = 1}) async {
    final data = await _asMapRequest('GET', '/comics/$comicId/comments', query: {'page': '$page'});
    final comments = Paged.parse<CommentSummary>(data['comments'], CommentSummary.fromJson);
    return ChapterComments(
      comments: [
        ...Paged.parse<CommentSummary>(data['topComments'], CommentSummary.fromJson).docs,
        ...comments.docs,
      ],
      total: comments.total,
    );
  }

  Future<List<Category>> categories() async {
    final data = await _asMapRequest('GET', '/categories');
    return Paged.parse<Category>(data['categories'], Category.fromJson).docs;
  }

  Future<List<String>> keywords() async {
    final data = await _asMapRequest('GET', '/keywords');
    final value = data['keywords'];
    if (value is List) return [for (final e in value) if (e is String) e];
    return const [];
  }
}
