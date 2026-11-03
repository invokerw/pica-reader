import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'api_config.dart';

class ImageFetchException implements Exception {
  ImageFetchException(this.message, {this.retryable = false, this.status});

  final String message;
  final bool retryable;
  final int? status;

  @override
  String toString() => message;
}

/// Downloads page images.
///
/// This deliberately does **not** reuse the API client: that one signs every
/// request and attaches the account token, and image URLs point at a CDN on a
/// different host. Sending `authorization`/`signature` there would leak a login
/// token to a third-party origin for no reason — the CDN only wants a browser
/// user agent, exactly like the on-screen reader (`NetworkImage`).
class ImageFetcher {
  ImageFetcher({
    Dio? dio,
    this.attempts = 3,
    this.timeouts = const [
      Duration(milliseconds: 400),
      Duration(milliseconds: 1200),
      Duration(milliseconds: 3000),
    ],
  }) : _dio = dio ?? _defaultDio();

  final Dio _dio;
  final int attempts;
  final List<Duration> timeouts;

  static Dio _defaultDio() {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.bytes,
      followRedirects: true,
      maxRedirects: 5,
      // A 4xx is a real answer; only 5xx is worth retrying.
      validateStatus: (status) => status != null && status < 500,
      headers: const {'User-Agent': ApiConfig.userAgent},
    ));
    return dio;
  }

  /// Fetches one page, retrying timeouts, 5xx and 429 with backoff.
  ///
  /// A body that is not an image is retried too: that is what a captive portal
  /// or a blocked CDN returns, and it arrives as `200 text/html`.
  Future<Uint8List> fetch(String url) async {
    var lastError = ImageFetchException('下载失败');
    for (var attempt = 0; attempt < attempts; attempt++) {
      try {
        final response = await _dio.get<List<int>>(
          url,
          options: Options(responseType: ResponseType.bytes),
        );
        final status = response.statusCode ?? 0;
        if (status == 429 || status >= 500) {
          throw ImageFetchException('服务器繁忙 (HTTP $status)', retryable: true, status: status);
        }
        if (status != 200) {
          throw ImageFetchException('图片请求失败 (HTTP $status)', status: status);
        }
        final data = response.data;
        if (data == null || data.isEmpty) {
          throw ImageFetchException('图片内容为空', retryable: true, status: status);
        }
        final bytes = data is Uint8List ? data : Uint8List.fromList(data);
        if (sniffExtension(bytes) == null) {
          throw ImageFetchException('返回的内容不是图片', retryable: true, status: status);
        }
        return bytes;
      } on ImageFetchException catch (error) {
        lastError = error;
        if (!error.retryable) rethrow;
      } on DioException catch (error) {
        final retryable = switch (error.type) {
          DioExceptionType.connectionTimeout ||
          DioExceptionType.sendTimeout ||
          DioExceptionType.receiveTimeout ||
          DioExceptionType.connectionError ||
          DioExceptionType.badResponse ||
          DioExceptionType.badCertificate =>
            true,
          _ => false,
        };
        lastError = ImageFetchException(_describe(error), retryable: retryable);
        if (!retryable) throw lastError;
      }
      if (attempt + 1 < attempts) {
        final wait = timeouts[attempt < timeouts.length ? attempt : timeouts.length - 1];
        await Future<void>.delayed(wait);
      }
    }
    throw lastError;
  }

  static String _describe(DioException error) => switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          '下载超时',
        DioExceptionType.connectionError => '无法连接图片服务器',
        _ => '下载失败：${error.message ?? error.type.name}',
      };

  /// Identifies the image format from its magic bytes.
  ///
  /// Returns `null` for anything else (an HTML error page, a login redirect),
  /// which is the signal that the bytes must not be written into a CBZ.
  static String? sniffExtension(Uint8List bytes) {
    if (bytes.length < 12) return null;
    if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) return 'jpg';
    if (bytes[0] == 0x89 && bytes[1] == 0x50 && bytes[2] == 0x4E && bytes[3] == 0x47) {
      return 'png';
    }
    if (bytes[0] == 0x47 && bytes[1] == 0x49 && bytes[2] == 0x46 && bytes[3] == 0x38) {
      return 'gif';
    }
    if (bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46 &&
        bytes[8] == 0x57 &&
        bytes[9] == 0x45 &&
        bytes[10] == 0x42 &&
        bytes[11] == 0x50) {
      return 'webp';
    }
    return null;
  }

  void close() => _dio.close(force: true);
}
