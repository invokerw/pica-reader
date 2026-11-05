import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pica_reader/src/api/api_client.dart';
import 'package:pica_reader/src/api/models.dart';
import 'package:pica_reader/src/state/downloads.dart';
import 'package:pica_reader/src/state/library.dart';
import 'package:pica_reader/src/state/settings.dart';
import 'package:pica_reader/src/storage/comic_archive.dart';
import 'package:pica_reader/src/storage/comic_info.dart';
import 'package:pica_reader/src/ui/reader_page.dart';
import 'package:provider/provider.dart';

/// A real 1x1 PNG; the decoder has to accept the bytes.
final _onePixelPng = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
);

const _episodes = [
  Episode(id: 'ep-1', title: '第 1 话', order: 1),
  Episode(id: 'ep-2', title: '第 2 话', order: 2),
  Episode(id: 'ep-3', title: '第 3 话', order: 3),
];

class _FakeApi extends ApiClient {
  @override
  Future<Paged<Episode>> episodes(String comicId, {int page = 1}) async =>
      Paged(docs: page == 1 ? _episodes : const [], total: _episodes.length, page: 1, pages: 1);
}

/// Every chapter is on disk, so the reader never touches the network.
class _FakeDownloads extends DownloadManager {
  _FakeDownloads(this.files)
      : super(
          resolvePages: (_, _) async => const [],
          root: () async => '',
        );

  final Map<int, String> files;

  @override
  String? localPathOf(String comicId, int order) => files[order];
}

class _RecordingLibrary extends Library {
  final orders = <int>[];

  @override
  void record({
    required String comicId,
    required String comicTitle,
    required String thumb,
    required int order,
    required int page,
    required int totalPages,
  }) {
    orders.add(order);
  }
}

/// Pumps long enough for the archive to be read off the engine thread and the
/// sheet animation to finish.
Future<void> _settle(WidgetTester tester) async {
  for (var round = 0; round < 10; round++) {
    await tester
        .runAsync(() => Future<void>.delayed(const Duration(milliseconds: 30)));
    await tester.pump(const Duration(milliseconds: 30));
  }
  await tester.pump(const Duration(milliseconds: 400));
}

Widget _app({
  required ApiClient api,
  required DownloadManager downloads,
  required Library library,
  required Widget home,
}) {
  return MultiProvider(
    providers: [
      Provider<ApiClient>.value(value: api),
      ChangeNotifierProvider<Settings>(create: (_) => Settings()),
      ChangeNotifierProvider<Library>.value(value: library),
      ChangeNotifierProvider<DownloadManager>.value(value: downloads),
    ],
    child: MaterialApp(home: home),
  );
}

void main() {
  late Directory temp;
  late Map<int, String> chapterFiles;

  setUpAll(() async {
    temp = await Directory.systemTemp.createTemp('pica_reader_chapters');
    chapterFiles = {};
    for (final order in [1, 2, 3]) {
      final pages = <String>[];
      for (var index = 0; index < 2; index++) {
        final file =
            File('${temp.path}${Platform.pathSeparator}$order-$index.png');
        await file.writeAsBytes(_onePixelPng);
        pages.add(file.path);
      }
      final target = '${temp.path}${Platform.pathSeparator}第$order话.cbz';
      await ComicArchive.write(
        targetPath: target,
        pageFiles: pages,
        comicInfoXml:
            ComicInfo(series: '夏日回声', number: order, title: '第 $order 话')
                .toXml(),
      );
      chapterFiles[order] = target;
    }
  });

  tearDownAll(() async {
    if (temp.existsSync()) await temp.delete(recursive: true);
  });

  testWidgets('the chapter list opens over the reader and switches chapters in place',
      (tester) async {
    tester.view.physicalSize = const Size(411, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final library = _RecordingLibrary();
    await tester.pumpWidget(_app(
      api: _FakeApi(),
      downloads: _FakeDownloads(chapterFiles),
      library: library,
      home: const ReaderPage(
        comicId: 'comic-1',
        comicTitle: '夏日回声',
        thumb: '',
        episode: Episode(id: 'ep-1', title: '第 1 话', order: 1),
      ),
    ));
    await _settle(tester);

    expect(find.textContaining('第 1 话'), findsOneWidget);

    // The title is the way into the chapter list.
    await tester.tap(find.textContaining('第 1 话'));
    await _settle(tester);
    expect(find.text('章节'), findsOneWidget);
    expect(find.text('第 3 话'), findsOneWidget);

    await tester.tap(find.text('第 3 话'));
    await _settle(tester);

    expect(find.text('章节'), findsNothing);
    expect(find.textContaining('第 3 话'), findsOneWidget);
    expect(find.textContaining('第 1 话'), findsNothing);
    // The chapter that was left behind is what gets written to history.
    expect(library.orders, contains(1));
  });

  testWidgets('the previous arrow opens the end of the previous chapter',
      (tester) async {
    tester.view.physicalSize = const Size(411, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final library = _RecordingLibrary();
    await tester.pumpWidget(_app(
      api: _FakeApi(),
      downloads: _FakeDownloads(chapterFiles),
      library: library,
      home: const ReaderPage(
        comicId: 'comic-1',
        comicTitle: '夏日回声',
        thumb: '',
        episode: Episode(id: 'ep-2', title: '第 2 话', order: 2),
      ),
    ));
    await _settle(tester);
    expect(find.textContaining('第 2 话'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.skip_previous));
    await _settle(tester);

    // Flipping back lands on the last page, where the end-of-chapter card is.
    expect(find.textContaining('第 1 话'), findsOneWidget);
    expect(find.text('本话完'), findsOneWidget);

    await tester.tap(find.text('下一话'));
    await _settle(tester);

    expect(find.textContaining('第 2 话'), findsOneWidget);
    expect(find.text('本话完'), findsNothing);
  });
}
