/// Lenient JSON models for the endpoints this app uses.
///
/// Field names come from the generated kotlinx-serializer descriptors that were
/// recovered with REA (`analysis/rea_model_schema.json`); unknown keys are
/// ignored so a server-side addition never breaks the app.
library;

int asInt(Object? value, [int fallback = 0]) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}

double asDouble(Object? value, [double fallback = 0]) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? fallback;
  return fallback;
}

String asString(Object? value, [String fallback = '']) {
  if (value is String) return value;
  if (value == null) return fallback;
  return value.toString();
}

bool asBool(Object? value, [bool fallback = false]) {
  if (value is bool) return value;
  return fallback;
}

List<String> asStringList(Object? value) {
  if (value is! List) return const [];
  return [
    for (final item in value)
      if (item is String) item,
  ];
}

Map<String, dynamic> asMap(Object? value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return value.map((k, v) => MapEntry('$k', v));
  return const {};
}

/// A `{docs, total, page, pages, limit}` envelope. Leaderboard and random
/// endpoints send a bare array instead, which is accepted here too.
class Paged<T> {
  const Paged({
    required this.docs,
    this.total = 0,
    this.page = 1,
    this.pages = 0,
    this.limit = 0,
  });

  final List<T> docs;
  final int total;
  final int page;
  final int pages;
  final int limit;

  bool get isEmpty => docs.isEmpty;

  static Paged<T> parse<T>(
    Object? value,
    T Function(Map<String, dynamic>) item,
  ) {
    if (value is List) {
      return Paged<T>(
        docs: [for (final e in value) item(asMap(e))],
        total: value.length,
        limit: value.length,
        pages: 1,
      );
    }
    final map = asMap(value);
    final docs = map['docs'];
    return Paged<T>(
      docs: docs is List ? [for (final e in docs) item(asMap(e))] : const [],
      total: asInt(map['total']),
      page: asInt(map['page'], 1),
      pages: asInt(map['pages']),
      limit: asInt(map['limit']),
    );
  }
}

class Comic {
  const Comic({
    required this.id,
    required this.title,
    this.author = '',
    this.description = '',
    this.thumb = '',
    this.totalViews = 0,
    this.totalLikes = 0,
    this.likesCount = 0,
    this.pagesCount = 0,
    this.epsCount = 0,
    this.finished = false,
    this.categories = const [],
    this.tags = const [],
    this.updatedAt = '',
  });

  final String id;
  final String title;
  final String author;
  final String description;
  final String thumb;
  final int totalViews;
  final int totalLikes;
  final int likesCount;
  final int pagesCount;
  final int epsCount;
  final bool finished;
  final List<String> categories;
  final List<String> tags;
  final String updatedAt;

  bool get isUsable => id.isNotEmpty;

  factory Comic.fromJson(Map<String, dynamic> json) => Comic(
        id: asString(json['_id']),
        title: asString(json['title'], '无标题'),
        author: asString(json['author']),
        description: asString(json['description']),
        thumb: asString(json['thumb']),
        totalViews: asInt(json['totalViews']),
        totalLikes: asInt(json['totalLikes']),
        likesCount: asInt(json['likesCount']),
        pagesCount: asInt(json['pagesCount']),
        epsCount: asInt(json['epsCount']),
        finished: asBool(json['finished']),
        categories: asStringList(json['categories']),
        tags: asStringList(json['tags']),
        updatedAt: asString(json['updated_at']),
      );
}

class Category {
  const Category({required this.title, this.id = '', this.thumb = ''});

  final String id;
  final String title;
  final String thumb;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: asString(json['_id']),
        title: asString(json['title']),
        thumb: asString(json['thumb']),
      );
}

class Episode {
  const Episode({required this.id, required this.title, required this.order});

  final String id;
  final String title;
  final int order;

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: asString(json['_id']),
        title: asString(json['title'], '第 ${asInt(json['order'])} 话'),
        order: asInt(json['order']),
      );
}

class ImageInfo {
  const ImageInfo({required this.fileServer, required this.path, this.originalName = ''});

  final String fileServer;
  final String path;
  final String originalName;

  factory ImageInfo.fromJson(Map<String, dynamic> json) => ImageInfo(
        fileServer: asString(json['fileServer']),
        path: asString(json['path']),
        originalName: asString(json['originalName']),
      );
}

class ComicPage {
  const ComicPage({required this.id, required this.media});

  final String id;
  final ImageInfo media;

  factory ComicPage.fromJson(Map<String, dynamic> json) => ComicPage(
        id: asString(json['id']).isEmpty ? asString(json['_id']) : asString(json['id']),
        media: ImageInfo.fromJson(asMap(json['media'])),
      );
}

class CommentSummary {
  const CommentSummary({
    required this.id,
    required this.content,
    this.author = '',
    this.likes = 0,
    this.createdAt = '',
  });

  final String id;
  final String content;
  final String author;
  final int likes;
  final String createdAt;

  factory CommentSummary.fromJson(Map<String, dynamic> json) {
    final user = asMap(json['user'] ?? json['_user']);
    return CommentSummary(
      id: asString(json['_id']),
      content: asString(json['content']),
      author: asString(user['name']),
      likes: asInt(json['likesCount']),
      createdAt: asString(json['created_at']),
    );
  }
}

class ChapterComments {
  const ChapterComments({required this.comments, this.total = 0});

  final List<CommentSummary> comments;
  final int total;
}

class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    this.email = '',
    this.avatar = '',
    this.level = 0,
    this.exp = 0,
    this.title = '',
  });

  final String id;
  final String name;
  final String email;
  final String avatar;
  final int level;
  final int exp;
  final String title;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: asString(json['_id']),
        name: asString(json['name'], '读者'),
        email: asString(json['email']),
        avatar: asString(json['avatar']),
        level: asInt(json['level']),
        exp: asInt(json['exp']),
        title: asString(json['title']),
      );
}

class Session {
  const Session({required this.token, this.user});

  final String token;
  final UserProfile? user;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        token: asString(json['token']),
        user: json['user'] is Map ? UserProfile.fromJson(asMap(json['user'])) : null,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        if (user != null) 'user': {'_id': user!.id, 'name': user!.name, 'email': user!.email},
      };
}

class ApiException implements Exception {
  ApiException(this.message, {this.code, this.error});

  final String message;
  final int? code;
  final String? error;

  @override
  String toString() => message;
}

/// The server answers `error == "1023"` when the signed timestamp is too far
/// from its own clock.
class TimeSkewException extends ApiException {
  TimeSkewException() : super('本机时间与服务器差异过大，请校准系统时间后重试');
}

class AuthException extends ApiException {
  AuthException(super.message);
}
