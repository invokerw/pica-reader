import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pica_reader/src/state/downloads.dart';
import 'package:pica_reader/src/ui/downloads_page.dart';

DownloadManager _manager(String root) => DownloadManager(
      resolvePages: (comicId, order) async => const [],
      root: () async => root,
    );

Widget _app(DownloadManager manager) => ChangeNotifierProvider<DownloadManager>.value(
      value: manager,
      child: const MaterialApp(home: DownloadsPage()),
    );

/// Real file I/O never completes inside the fake-async zone of testWidgets,
/// so every async preparation goes through runAsync (and cleanup is sync).
Directory _tempDir() {
  final dir = Directory.systemTemp.createTempSync('pica_dl_page');
  addTearDown(() {
    if (dir.existsSync()) dir.deleteSync(recursive: true);
  });
  return dir;
}

void main() {
  testWidgets('empty library explains how to fill it', (tester) async {
    final temp = _tempDir();
    late DownloadManager manager;
    await tester.runAsync(() async {
      manager = _manager(temp.path);
      await manager.load();
    });

    await tester.pumpWidget(_app(manager));
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('离线漫画'), findsOneWidget);
    expect(find.textContaining('还没有离线章节'), findsOneWidget);
  });

  testWidgets('a downloaded chapter shows its size and actions', (tester) async {
    final temp = _tempDir();
    late DownloadManager manager;
    await tester.runAsync(() async {
      File('${temp.path}${Platform.pathSeparator}read.cbz')
          .writeAsBytesSync(List<int>.filled(2048, 0));
      File('${temp.path}${Platform.pathSeparator}index.json').writeAsStringSync(
        jsonEncode({
          'version': 1,
          'comics': [
            {
              'id': 'c1',
              'title': '测试漫画',
              'thumb': '',
              'author': '作者',
              'chapters': [
                {
                  'order': 1,
                  'title': '第1话 开始',
                  'state': 'done',
                  'pages': 20,
                  'done': 20,
                  'bytes': 2048,
                  'file': 'read.cbz',
                },
              ],
            },
          ],
        }),
      );
      manager = _manager(temp.path);
      await manager.load();
    });
    expect(manager.totalChapters, 1);

    await tester.pumpWidget(_app(manager));
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.text('测试漫画'), findsOneWidget);

    // The group is collapsed until tapped.
    await tester.tap(find.text('测试漫画'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.textContaining('第 1 话'), findsWidgets);
    expect(find.byIcon(Icons.check_circle), findsWidgets);
  });
}
