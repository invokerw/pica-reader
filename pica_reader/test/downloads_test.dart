import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:pica_reader/src/api/models.dart';
import 'package:pica_reader/src/state/downloads.dart';
import 'package:pica_reader/src/storage/comic_archive.dart';
import 'package:pica_reader/src/storage/library_paths.dart';

Uint8List pageBytes(int index, {int size = 2048}) {
  final bytes = Uint8List(size);
  bytes[0] = 0xFF;
  bytes[1] = 0xD8;
  bytes[2] = 0xFF;
  bytes[3] = 0xE1;
  for (var offset = 4; offset < size; offset++) {
    bytes[offset] = (offset * 31 + index) & 0xFF;
  }
  return bytes;
}

const comic = Comic(
  id: 'comic-1',
  title: '测试漫画:上',
  author: '作者',
  description: '简介 & 说明',
  epsCount: 5,
  categories: ['恋爱'],
  tags: ['日常'],
);

void main() {
  late HttpServer server;
  late List<String> requests;
  late Directory temp;

  setUp(() async {
    requests = [];
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((request) async {
      requests.add(request.uri.path);
      final name = request.uri.pathSegments.last;
      final index = int.tryParse(name.split('.').first) ?? 1;
      request.response.headers.contentType = ContentType('image', 'jpeg');
      request.response.add(pageBytes(index));
      await request.response.close();
    });
    temp = await Directory.systemTemp.createTemp('pica_dl_test');
  });

  tearDown(() async {
    await server.close(force: true);
    if (temp.existsSync()) await temp.delete(recursive: true);
  });

  List<String> urlsFor(int pages) => [
        for (var index = 1; index <= pages; index++)
          'http://127.0.0.1:${server.port}/$index.jpg',
      ];

  test('downloads a chapter into a readable CBZ and records it', () async {
    final manager = DownloadManager(
      resolvePages: (comicId, order) async => urlsFor(3),
      root: () async => temp.path,
      pagesPerChapter: () => 2,
      pacing: Duration.zero,
    );
    await manager.load();
    expect(manager.rootReady, isTrue);

    await manager.enqueue(comic: comic, episode: const Episode(id: 'e3', title: '第3话 深夜', order: 3));
    await manager.idle(timeout: const Duration(seconds: 30));

    final chapter = manager.chapterOf(comic.id, 3)!;
    expect(chapter.state, ChapterState.done, reason: chapter.error);
    expect(chapter.pagesDone, 3);
    expect(chapter.bytes, greaterThan(0));

    final path = manager.localPathOf(comic.id, 3);
    expect(path, isNotNull);
    expect(path!.endsWith('.cbz'), isTrue);
    // Folder and file names are the ones local comic readers expect.
    expect(path, contains('测试漫画_上'));
    expect(path, contains('第003话'));
    expect(File(path).existsSync(), isTrue);

    final reader = ComicArchiveReader.open(path);
    addTearDown(reader.close);
    expect(reader.pageCount, 3);
    expect(reader.pageBytes(1), pageBytes(2));

    // The temporary page folder is gone once the archive exists.
    final partDir = Directory('${temp.path}${Platform.pathSeparator}.part');
    expect(partDir.existsSync(), isFalse);

    // The manifest survives a restart.
    final reopened = DownloadManager(
      resolvePages: (comicId, order) async => urlsFor(3),
      root: () async => temp.path,
      pagesPerChapter: () => 2,
    );
    await reopened.load();
    expect(reopened.isDownloaded(comic.id, 3), isTrue);
    expect(reopened.totalChapters, 1);
  });

  test('resumes a chapter without re-downloading finished pages', () async {
    // Simulate an interrupted download: page 2 already sits on disk.
    final partDir = Directory(
      '${temp.path}${Platform.pathSeparator}.part'
      '${Platform.pathSeparator}${LibraryPaths.sanitizeSegment(comic.id)}'
      '${Platform.pathSeparator}3',
    );
    await partDir.create(recursive: true);
    await File('${partDir.path}${Platform.pathSeparator}002.jpg').writeAsBytes(pageBytes(2));

    final manager = DownloadManager(
      resolvePages: (comicId, order) async => urlsFor(3),
      root: () async => temp.path,
      pagesPerChapter: () => 1,
      pacing: Duration.zero,
    );
    await manager.load();
    await manager.enqueue(comic: comic, episode: const Episode(id: 'e3', title: '第3话', order: 3));
    await manager.idle(timeout: const Duration(seconds: 30));

    expect(manager.chapterOf(comic.id, 3)!.state, ChapterState.done);
    // Page 2 was kept, pages 1 and 3 were fetched.
    expect(requests, containsAll(['/1.jpg', '/3.jpg']));
    expect(requests, isNot(contains('/2.jpg')));

    final reader = ComicArchiveReader.open(manager.localPathOf(comic.id, 3)!);
    addTearDown(reader.close);
    expect(reader.pageBytes(1), pageBytes(2));
  });

  test('nothing resumes by itself after a restart', () async {
    final manifest = {
      'version': 1,
      'comics': [
        {
          'id': comic.id,
          'title': comic.title,
          'chapters': [
            {'order': 1, 'title': '第1话', 'state': 'running', 'pages': 10, 'done': 4},
            {'order': 2, 'title': '第2话', 'state': 'queued', 'pages': 0, 'done': 0},
          ],
        },
      ],
    };
    await File('${temp.path}${Platform.pathSeparator}${LibraryPaths.manifestName}')
        .writeAsString(jsonEncode(manifest));

    final manager = DownloadManager(
      resolvePages: (comicId, order) async => urlsFor(3),
      root: () async => temp.path,
    );
    await manager.load();
    expect(manager.chapterOf(comic.id, 1)!.state, ChapterState.paused);
    expect(manager.chapterOf(comic.id, 2)!.state, ChapterState.paused);
    expect(manager.pendingCount, 0);
  });

  test('a corrupt manifest does not break the library', () async {
    await File('${temp.path}${Platform.pathSeparator}${LibraryPaths.manifestName}')
        .writeAsString('{not json');
    final manager = DownloadManager(
      resolvePages: (comicId, order) async => urlsFor(1),
      root: () async => temp.path,
    );
    await manager.load();
    expect(manager.comics, isEmpty);
    expect(manager.rootReady, isTrue);
  });

  test('rejects non-image responses instead of packing HTML', () async {
    await server.close(force: true);
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((request) async {
      request.response.headers.contentType = ContentType.html;
      request.response.write('<html>blocked</html>');
      await request.response.close();
    });

    final manager = DownloadManager(
      resolvePages: (comicId, order) async => urlsFor(1),
      root: () async => temp.path,
      pagesPerChapter: () => 1,
      pacing: Duration.zero,
    );
    await manager.load();
    await manager.enqueue(comic: comic, episode: const Episode(id: 'e1', title: '第1话', order: 1));
    await manager.idle(timeout: const Duration(seconds: 60));

    final chapter = manager.chapterOf(comic.id, 1)!;
    expect(chapter.state, ChapterState.failed);
    expect(chapter.error, contains('不是图片'));
    expect(manager.localPathOf(comic.id, 1), isNull);
  });

  test('deleting a chapter removes the file and the entry', () async {
    final manager = DownloadManager(
      resolvePages: (comicId, order) async => urlsFor(2),
      root: () async => temp.path,
      pagesPerChapter: () => 1,
      pacing: Duration.zero,
    );
    await manager.load();
    await manager.enqueue(comic: comic, episode: const Episode(id: 'e1', title: '第1话', order: 1));
    await manager.idle(timeout: const Duration(seconds: 30));
    final path = manager.localPathOf(comic.id, 1)!;
    expect(File(path).existsSync(), isTrue);

    await manager.removeChapter(comic.id, 1);
    expect(File(path).existsSync(), isFalse);
    expect(manager.chapterOf(comic.id, 1), isNull);
    expect(manager.comics, isEmpty);
  });
}
