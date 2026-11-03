import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pica_reader/src/storage/comic_archive.dart';
import 'package:pica_reader/src/storage/comic_info.dart';
import 'package:pica_reader/src/ui/chapter_source.dart';
import 'package:pica_reader/src/ui/widgets/cbz_page_image.dart';

/// A real 1x1 PNG: the decoder must accept it, so fake bytes will not do.
final _onePixelPng = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a page inside a CBZ decodes to an image', () async {
    final temp = await Directory.systemTemp.createTemp('pica_reader_offline');
    addTearDown(() async {
      if (temp.existsSync()) await temp.delete(recursive: true);
    });

    final pages = <String>[];
    for (var index = 0; index < 2; index++) {
      final file = File('${temp.path}${Platform.pathSeparator}$index.png');
      await file.writeAsBytes(_onePixelPng);
      pages.add(file.path);
    }
    final target = '${temp.path}${Platform.pathSeparator}第一卷.cbz';
    await ComicArchive.write(
      targetPath: target,
      pageFiles: pages,
      comicInfoXml: const ComicInfo(series: '第一卷', number: 1, title: '开始').toXml(),
    );

    // The reader path a downloaded chapter takes.
    final chapter = LocalChapter.open(target);
    addTearDown(chapter.dispose);
    expect(chapter.isLocal, isTrue);
    expect(chapter.length, 2);

    final provider = chapter.imageAt(1);
    expect(provider, isA<CbzPageImage>());

    final info = await _decode(provider);
    expect(info.image.width, 1);
    expect(info.image.height, 1);
  });

  test('every page of an archive can be decoded in order', () async {
    final temp = await Directory.systemTemp.createTemp('pica_reader_offline');
    addTearDown(() async {
      if (temp.existsSync()) await temp.delete(recursive: true);
    });
    final pages = <String>[];
    for (var index = 0; index < 5; index++) {
      final file = File('${temp.path}${Platform.pathSeparator}page$index.png');
      await file.writeAsBytes(_onePixelPng);
      pages.add(file.path);
    }
    final target = '${temp.path}${Platform.pathSeparator}five.cbz';
    await ComicArchive.write(
      targetPath: target,
      pageFiles: pages,
      comicInfoXml: const ComicInfo(series: 'five', number: 1, title: 'x').toXml(),
    );

    final archive = ComicArchiveReader.open(target);
    addTearDown(archive.close);
    for (var index = 0; index < archive.pageCount; index++) {
      final info = await _decode(CbzPageImage(archive, index));
      expect(info.image.width, 1);
      info.dispose();
    }
  });
}

Future<ImageInfo> _decode(ImageProvider provider) {
  final stream = provider.resolve(ImageConfiguration.empty);
  final completer = Completer<ImageInfo>();
  late ImageStreamListener listener;
  listener = ImageStreamListener(
    (info, _) {
      stream.removeListener(listener);
      if (!completer.isCompleted) completer.complete(info);
    },
    onError: (error, stack) {
      stream.removeListener(listener);
      if (!completer.isCompleted) completer.completeError(error, stack);
    },
  );
  stream.addListener(listener);
  return completer.future;
}
