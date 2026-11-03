import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../api/image_fetcher.dart';
import '../api/models.dart';
import '../storage/comic_archive.dart';
import '../storage/comic_info.dart';
import '../storage/library_paths.dart';

enum ChapterState { queued, running, paused, done, failed }

String chapterStateLabel(ChapterState state) => switch (state) {
      ChapterState.queued => '排队中',
      ChapterState.running => '下载中',
      ChapterState.paused => '已暂停',
      ChapterState.done => '已完成',
      ChapterState.failed => '失败',
    };

String formatBytes(int bytes) {
  if (bytes <= 0) return '0 B';
  const units = ['B', 'KB', 'MB', 'GB', 'TB'];
  var value = bytes.toDouble();
  var unit = 0;
  while (value >= 1024 && unit < units.length - 1) {
    value /= 1024;
    unit++;
  }
  final digits = value >= 100 || unit == 0 ? 0 : 1;
  return '${value.toStringAsFixed(digits)} ${units[unit]}';
}

/// One chapter (one CBZ file) tracked by the download manager.
class ChapterDownload {
  ChapterDownload({
    required this.order,
    required this.title,
    this.episodeId = '',
    this.state = ChapterState.queued,
    this.totalPages = 0,
    this.pagesDone = 0,
    this.bytes = 0,
    this.file = '',
    this.error = '',
    this.updatedAt = 0,
  });

  final int order;

  /// Raw episode title from the API, e.g. `第3话 深夜`.
  final String title;

  /// Server-side chapter id, kept for the CBZ's provenance notes.
  final String episodeId;
  ChapterState state;
  int totalPages;
  int pagesDone;
  int bytes;

  /// Path relative to the download root, empty until the archive exists.
  String file;
  String error;
  int updatedAt;

  bool get isDone => state == ChapterState.done;
  bool get isRunning => state == ChapterState.running;
  bool get isQueued => state == ChapterState.queued;
  bool get isPaused => state == ChapterState.paused;
  bool get isFailed => state == ChapterState.failed;
  bool get isActive => isRunning || isQueued;

  double get progress {
    if (isDone) return 1;
    if (totalPages <= 0) return 0;
    return (pagesDone / totalPages).clamp(0, 1);
  }

  Map<String, dynamic> toJson() => {
        'order': order,
        'title': title,
        if (episodeId.isNotEmpty) 'episodeId': episodeId,
        'state': state.name,
        'pages': totalPages,
        'done': pagesDone,
        'bytes': bytes,
        if (file.isNotEmpty) 'file': file,
        if (error.isNotEmpty) 'error': error,
        'updatedAt': updatedAt,
      };

  static ChapterDownload fromJson(Map<String, dynamic> json) {
    final rawState = asString(json['state']);
    return ChapterDownload(
      order: asInt(json['order']),
      title: asString(json['title']),
      episodeId: asString(json['episodeId']),
      state: ChapterState.values.firstWhere(
        (value) => value.name == rawState,
        orElse: () => ChapterState.paused,
      ),
      totalPages: asInt(json['pages']),
      pagesDone: asInt(json['done']),
      bytes: asInt(json['bytes']),
      file: asString(json['file']),
      error: asString(json['error']),
      updatedAt: asInt(json['updatedAt']),
    );
  }
}

/// One comic and every chapter of it that was queued or downloaded.
class ComicDownload {
  ComicDownload({
    required this.id,
    required this.title,
    this.thumb = '',
    this.author = '',
    this.description = '',
    this.genres = const [],
    this.episodeCount = 0,
  });

  final String id;
  String title;
  String thumb;
  String author;
  String description;
  List<String> genres;
  int episodeCount;
  final Map<int, ChapterDownload> chapters = {};

  int get downloadedCount => chapters.values.where((c) => c.isDone).length;
  int get bytes => chapters.values.fold(0, (sum, c) => sum + c.bytes);
  bool get hasWork => chapters.values.any((c) => c.isActive);
  int get latestUpdate =>
      chapters.values.fold(0, (latest, c) => c.updatedAt > latest ? c.updatedAt : latest);

  List<ChapterDownload> get sortedChapters {
    final list = chapters.values.toList()..sort((a, b) => a.order.compareTo(b.order));
    return list;
  }
}

class _Aborted implements Exception {
  const _Aborted();
}

/// Queue, downloader and on-disk manifest for the offline library.
///
/// One chapter is fetched at a time (each chapter runs several page requests in
/// parallel), which keeps the CDN from seeing a burst of dozens of connections
/// and keeps the progress display honest. Chapters land as CBZ files, the one
/// format local comic readers understand.
class DownloadManager extends ChangeNotifier {
  DownloadManager({
    required this.resolvePages,
    required this.root,
    this.pagesPerChapter = _defaultPagesPerChapter,
    ImageFetcher? fetcher,
    this.pacing = const Duration(milliseconds: 90),
  }) : _fetcher = fetcher ?? ImageFetcher();

  static int _defaultPagesPerChapter() => 4;

  /// Resolves page URLs for a chapter — injected so tests can serve a local
  /// HTTP server instead of the real API.
  final Future<List<String>> Function(String comicId, int order) resolvePages;

  /// Resolves the download directory, honouring a user setting.
  final Future<String> Function() root;

  /// Parallel page requests inside one chapter.
  final int Function() pagesPerChapter;

  /// Extra delay between page requests; jitter is added on top.
  final Duration pacing;

  final ImageFetcher _fetcher;
  final Map<String, ComicDownload> _comics = {};
  final Random _random = Random();

  String _rootPath = '';
  bool _rootReady = false;
  bool _paused = false;
  bool _running = false;
  bool _loaded = false;
  bool _disposed = false;
  Timer? _saveTimer;

  bool get loaded => _loaded;
  bool get isPaused => _paused;
  bool get rootReady => _rootReady;
  String get rootPath => _rootPath;

  List<ComicDownload> get comics {
    final list = _comics.values.toList()
      ..sort((a, b) => b.latestUpdate.compareTo(a.latestUpdate));
    return list;
  }

  int get totalBytes => _comics.values.fold(0, (sum, comic) => sum + comic.bytes);

  int get totalChapters =>
      _comics.values.fold(0, (sum, comic) => sum + comic.downloadedCount);

  int get pendingCount => _comics.values.fold(
        0,
        (sum, comic) => sum + comic.chapters.values.where((c) => c.isActive).length,
      );

  ComicDownload? comicOf(String comicId) => _comics[comicId];

  ChapterDownload? chapterOf(String comicId, int order) => _comics[comicId]?.chapters[order];

  bool isDownloaded(String comicId, int order) => localPathOf(comicId, order) != null;

  /// Absolute path of a finished chapter, or `null` when it is absent.
  String? localPathOf(String comicId, int order) {
    final chapter = chapterOf(comicId, order);
    if (chapter == null || !chapter.isDone || chapter.file.isEmpty) return null;
    final path = '$_rootPath${Platform.pathSeparator}'
        '${chapter.file.replaceAll('/', Platform.pathSeparator)}';
    return File(path).existsSync() ? path : null;
  }

  /// Reads the manifest. Call once at start-up (and after the root changes).
  Future<void> load() async {
    _rootPath = await root();
    _rootReady = _rootPath.isNotEmpty;
    _comics.clear();
    if (_rootReady) {
      final manifest = File('$_rootPath${Platform.pathSeparator}${LibraryPaths.manifestName}');
      if (manifest.existsSync()) {
        try {
          final decoded = jsonDecode(await manifest.readAsString());
          final root = asMap(decoded);
          final items = root['comics'];
          if (items is List) {
            for (final raw in items) {
              final comic = _comicFromJson(asMap(raw));
              if (comic != null) _comics[comic.id] = comic;
            }
          }
        } on FormatException {
          // A corrupt manifest must not stop the app; files stay on disk and
          // chapters can be downloaded again.
        } on FileSystemException {
          // Unreadable for now (lock, permissions) — treat as empty.
        }
      }
    }
    // Nothing resumes by itself: a download that was running when the app was
    // closed becomes "paused", otherwise every launch would start pulling
    // gigabytes without the user asking.
    for (final comic in _comics.values) {
      for (final chapter in comic.chapters.values) {
        if (chapter.isActive) chapter.state = ChapterState.paused;
      }
    }
    _loaded = true;
    _notify();
  }

  /// Re-reads the manifest, e.g. after the download folder changed.
  Future<void> reload() async {
    if (_running) pauseAll();
    await load();
  }

  ComicDownload? _comicFromJson(Map<String, dynamic> json) {
    final id = asString(json['id']);
    if (id.isEmpty) return null;
    final comic = ComicDownload(
      id: id,
      title: asString(json['title'], '无标题'),
      thumb: asString(json['thumb']),
      author: asString(json['author']),
      description: asString(json['description']),
      genres: asStringList(json['genres']),
      episodeCount: asInt(json['episodeCount']),
    );
    final chapters = json['chapters'];
    if (chapters is List) {
      for (final raw in chapters) {
        final chapter = ChapterDownload.fromJson(asMap(raw));
        if (chapter.order <= 0) continue;
        comic.chapters[chapter.order] = chapter;
      }
    }
    return comic;
  }

  ComicDownload _ensureComic(Comic comic) {
    final genres = _mergeGenres(comic);
    final existing = _comics[comic.id];
    if (existing != null) {
      existing
        ..title = comic.title
        ..thumb = comic.thumb
        ..author = comic.author
        ..description = comic.description
        ..genres = genres
        ..episodeCount = comic.epsCount;
      return existing;
    }
    final created = ComicDownload(
      id: comic.id,
      title: comic.title,
      thumb: comic.thumb,
      author: comic.author,
      description: comic.description,
      genres: genres,
      episodeCount: comic.epsCount,
    );
    _comics[comic.id] = created;
    return created;
  }

  /// Categories and tags overlap (both list `全彩`), and ComicInfo has no room
  /// for duplicates.
  static List<String> _mergeGenres(Comic comic) {
    final seen = <String>{};
    final merged = <String>[];
    for (final value in [...comic.categories, ...comic.tags]) {
      final trimmed = value.trim();
      if (trimmed.isEmpty) continue;
      if (seen.add(trimmed.toLowerCase())) merged.add(trimmed);
    }
    return merged;
  }

  /// Queues one chapter. Finished chapters are left alone (idempotent).
  Future<void> enqueue({required Comic comic, required Episode episode}) async {
    if (!_rootReady) {
      _rootPath = await root();
      _rootReady = _rootPath.isNotEmpty;
    }
    final owner = _ensureComic(comic);
    final existing = owner.chapters[episode.order];
    if (existing != null && (existing.isDone || existing.isActive)) return;
    owner.chapters[episode.order] = ChapterDownload(
      order: episode.order,
      title: episode.title,
      episodeId: episode.id,
      state: _rootReady ? ChapterState.queued : ChapterState.failed,
      error: _rootReady ? '' : '无法创建下载目录',
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    _notify();
    _saveSoon();
    _pump();
  }

  /// Queues every chapter that is not downloaded yet.
  Future<void> enqueueAll({required Comic comic, required List<Episode> episodes}) async {
    for (final episode in episodes) {
      await enqueue(comic: comic, episode: episode);
    }
  }

  void pauseAll() {
    _paused = true;
    for (final chapter in _allChapters) {
      if (chapter.isQueued) chapter.state = ChapterState.paused;
    }
    _notify();
    _saveSoon();
  }

  void resumeAll() {
    _paused = false;
    for (final chapter in _allChapters) {
      if (chapter.isPaused) chapter.state = ChapterState.queued;
    }
    _notify();
    _saveSoon();
    _pump();
  }

  void pauseChapter(ChapterDownload chapter) {
    if (chapter.isQueued) {
      chapter.state = ChapterState.paused;
    } else if (chapter.isRunning) {
      // The worker loop notices at the next page boundary.
      chapter.state = ChapterState.paused;
    }
    _notify();
    _saveSoon();
  }

  void resumeChapter(ChapterDownload chapter) {
    if (!chapter.isPaused && !chapter.isFailed) return;
    chapter.state = ChapterState.queued;
    chapter.error = '';
    _notify();
    _saveSoon();
    _pump();
  }

  Future<void> retry(ChapterDownload chapter) async {
    chapter.state = ChapterState.queued;
    chapter.error = '';
    chapter.pagesDone = 0;
    _notify();
    _saveSoon();
    _pump();
  }

  /// Deletes one chapter: removes the file, the manifest entry and the pages
  /// left over from an interrupted download.
  Future<void> removeChapter(String comicId, int order, {bool deleteFile = true}) async {
    final comic = _comics[comicId];
    final chapter = comic?.chapters[order];
    if (comic == null || chapter == null) return;
    comic.chapters.remove(order);
    if (deleteFile) {
      final path = chapter.file.isEmpty
          ? null
          : '$_rootPath${Platform.pathSeparator}${chapter.file.replaceAll('/', Platform.pathSeparator)}';
      if (path != null) await _deleteIfExists(File(path));
      await _deletePartDir(comicId, order);
    }
    if (comic.chapters.isEmpty) _comics.remove(comicId);
    _notify();
    await _save();
  }

  Future<void> removeComic(String comicId) async {
    final comic = _comics[comicId];
    if (comic == null) return;
    for (final chapter in comic.chapters.values) {
      if (chapter.file.isNotEmpty) {
        await _deleteIfExists(File(
          '$_rootPath${Platform.pathSeparator}${chapter.file.replaceAll('/', Platform.pathSeparator)}',
        ));
      }
      await _deletePartDir(comicId, chapter.order);
    }
    _comics.remove(comicId);
    _notify();
    await _save();
  }

  /// Resolves when the queue has drained (used by tests and by "download all").
  Future<void> idle({Duration timeout = const Duration(minutes: 10)}) async {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      final busy = _running || _allChapters.any((c) => c.isActive);
      if (!busy) {
        // Flush the debounced manifest so a follow-up read sees the result.
        _saveTimer?.cancel();
        await _save();
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 25));
    }
  }

  List<ChapterDownload> get _allChapters => [
        for (final comic in _comics.values) ...comic.chapters.values,
      ];

  Future<void> _pump() async {
    if (_running || _paused || !_rootReady) return;
    _running = true;
    try {
      while (!_paused && _rootReady) {
        final next = _nextQueued();
        if (next == null) break;
        await _run(next);
      }
    } finally {
      _running = false;
    }
  }

  (ComicDownload, ChapterDownload)? _nextQueued() {
    for (final comic in _comics.values) {
      for (final chapter in comic.sortedChapters) {
        if (chapter.isQueued) return (comic, chapter);
      }
    }
    return null;
  }

  Future<void> _run((ComicDownload, ChapterDownload) job) async {
    final (comic, chapter) = job;
    chapter
      ..state = ChapterState.running
      ..error = ''
      ..pagesDone = 0
      ..updatedAt = DateTime.now().millisecondsSinceEpoch;
    _notify();
    _saveSoon();

    final partDir = Directory(
      '$_rootPath${Platform.pathSeparator}${LibraryPaths.partDirName}'
      '${Platform.pathSeparator}${LibraryPaths.sanitizeSegment(comic.id)}'
      '${Platform.pathSeparator}${chapter.order}',
    );
    try {
      if (!_rootReady) throw StateError('下载目录不可用');
      final urls = await resolvePages(comic.id, chapter.order);
      if (urls.isEmpty) throw StateError('这一话没有图片');
      chapter.totalPages = urls.length;
      await partDir.create(recursive: true);

      final existing = _scanPartDir(partDir);
      chapter.pagesDone = existing.length;
      _notify();

      var cursor = 0;
      final parallel = pagesPerChapter().clamp(1, 8).toInt();
      Future<void> worker() async {
        while (true) {
          final index = cursor++;
          if (index >= urls.length) return;
          if (chapter.state != ChapterState.running) throw const _Aborted();
          if (existing.containsKey(index)) continue;
          final bytes = await _fetcher.fetch(urls[index]);
          if (chapter.state != ChapterState.running) throw const _Aborted();
          final extension = ImageFetcher.sniffExtension(bytes) ?? 'jpg';
          final target = File(
            '${partDir.path}${Platform.pathSeparator}'
            '${LibraryPaths.pageName(index, extension, total: urls.length)}',
          );
          await target.writeAsBytes(bytes, flush: true);
          chapter.pagesDone += 1;
          chapter.updatedAt = DateTime.now().millisecondsSinceEpoch;
          _notify();
          final jitter = pacing + Duration(milliseconds: _random.nextInt(160));
          if (jitter > Duration.zero) await Future<void>.delayed(jitter);
        }
      }

      await Future.wait(
        [for (var i = 0; i < parallel; i++) worker()],
        // Do not wait for in-flight page requests when the user pauses.
        eagerError: true,
      );
      if (chapter.state != ChapterState.running) throw const _Aborted();

      final pages = _orderedPages(partDir, urls.length);
      final directory = LibraryPaths.sanitizeSegment(comic.title, fallback: '漫画');
      final fileName = LibraryPaths.chapterFileName(
        comicTitle: comic.title,
        order: chapter.order,
        episodeTitle: chapter.title,
      );
      final relative = '$directory/$fileName';
      final targetPath =
          '$_rootPath${Platform.pathSeparator}${relative.replaceAll('/', Platform.pathSeparator)}';

      final bytes = await ComicArchive.write(
        targetPath: targetPath,
        pageFiles: pages,
        comicInfoXml: _comicInfoFor(comic, chapter).toXml(),
        notice: _notice(chapter),
      );

      chapter
        ..state = ChapterState.done
        ..file = relative
        ..bytes = bytes
        ..pagesDone = chapter.totalPages
        ..updatedAt = DateTime.now().millisecondsSinceEpoch;
      await _deletePartDir(comic.id, chapter.order);
    } on _Aborted {
      chapter.state = ChapterState.paused;
    } catch (error) {
      chapter
        ..state = ChapterState.failed
        ..error = _describe(error)
        ..updatedAt = DateTime.now().millisecondsSinceEpoch;
    } finally {
      _notify();
      _saveSoon();
    }
  }

  ComicInfo _comicInfoFor(ComicDownload comic, ChapterDownload chapter) => ComicInfo(
        series: comic.title,
        number: chapter.order,
        title: LibraryPaths.cleanEpisodeTitle(chapter.title, chapter.order),
        count: comic.episodeCount,
        summary: comic.description,
        writer: comic.author,
        genres: comic.genres,
        pageCount: chapter.totalPages,
        notes: '来源：pica_reader（第三方客户端）\n'
            '漫画 ID：${comic.id}\n'
            '章节 ID：${chapter.episodeId.isNotEmpty ? chapter.episodeId : chapter.order}\n'
            '章节序号：${chapter.order}\n'
            '仅供个人离线阅读，请勿传播。',
      );

  static String _notice(ChapterDownload chapter) => '''
本文件由 pica_reader（第三方客户端）导出，仅供个人学习、离线阅读使用。

本压缩包内的所有漫画图片版权归原作者及相关权利人所有，
请勿用于任何商业用途，也不要再次分发。

章节：${chapter.title}（第 ${chapter.order} 话）
页数：${chapter.totalPages}
导出时间：${DateTime.now().toString().split('.').first}
''';

  static String _describe(Object error) {
    if (error is ImageFetchException) return error.message;
    if (error is ApiException) return error.message;
    if (error is StateError) return error.message;
    if (error is FormatException) return error.message;
    if (error is FileSystemException) return '写入失败：${error.osError?.message ?? error.message}';
    return '下载失败：$error';
  }

  Map<int, File> _scanPartDir(Directory dir) {
    final pages = <int, File>{};
    if (!dir.existsSync()) return pages;
    for (final entity in dir.listSync()) {
      if (entity is! File) continue;
      final name = entity.path.split(Platform.pathSeparator).last;
      final dot = name.indexOf('.');
      final index = int.tryParse(dot <= 0 ? name : name.substring(0, dot));
      if (index == null || index <= 0) continue;
      if (entity.lengthSync() == 0) {
        entity.deleteSync();
        continue;
      }
      pages[index - 1] = entity;
    }
    return pages;
  }

  List<String> _orderedPages(Directory dir, int total) {
    final pages = _scanPartDir(dir);
    final ordered = <String>[];
    for (var index = 0; index < total; index++) {
      final page = pages[index];
      if (page == null) throw StateError('第 ${index + 1} 页缺失');
      ordered.add(page.path);
    }
    return ordered;
  }

  Future<void> _deletePartDir(String comicId, int order) async {
    final separator = Platform.pathSeparator;
    final comicDir = Directory(
      '$_rootPath$separator${LibraryPaths.partDirName}'
      '$separator${LibraryPaths.sanitizeSegment(comicId)}',
    );
    await _deleteIfExists(Directory('${comicDir.path}$separator$order'));
    // Leave no empty scaffolding behind in the user's folder.
    try {
      if (comicDir.existsSync() && comicDir.listSync().isEmpty) comicDir.deleteSync();
      final partRoot = Directory('$_rootPath$separator${LibraryPaths.partDirName}');
      if (partRoot.existsSync() && partRoot.listSync().isEmpty) partRoot.deleteSync();
    } on FileSystemException {
      // An empty folder is untidy, not broken.
    }
  }

  static Future<void> _deleteIfExists(FileSystemEntity entity) async {
    try {
      if (entity.existsSync()) await entity.delete(recursive: true);
    } on FileSystemException {
      // A locked file (still open in a viewer) is not worth failing the action.
    }
  }

  void _notify() {
    if (_disposed) return;
    notifyListeners();
  }

  void _saveSoon() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 600), () {
      unawaited(_save());
    });
  }

  Future<void> _save() async {
    if (!_rootReady) return;
    _saveTimer?.cancel();
    final manifest = File('$_rootPath${Platform.pathSeparator}${LibraryPaths.manifestName}');
    final data = <String, dynamic>{
      'version': 1,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
      'comics': [
        for (final comic in _comics.values)
          {
            'id': comic.id,
            'title': comic.title,
            'thumb': comic.thumb,
            'author': comic.author,
            'description': comic.description,
            'genres': comic.genres,
            'episodeCount': comic.episodeCount,
            'chapters': [for (final chapter in comic.sortedChapters) chapter.toJson()],
          },
      ],
    };
    try {
      final temporary = File('${manifest.path}.tmp');
      await temporary.writeAsString(jsonEncode(data), flush: true);
      if (manifest.existsSync()) manifest.deleteSync();
      await temporary.rename(manifest.path);
    } on FileSystemException {
      // Losing the manifest only costs progress display; the CBZ files remain.
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _saveTimer?.cancel();
    super.dispose();
  }
}
