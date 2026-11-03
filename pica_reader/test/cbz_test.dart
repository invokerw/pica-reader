import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:pica_reader/src/storage/comic_archive.dart';
import 'package:pica_reader/src/storage/comic_info.dart';
import 'package:pica_reader/src/storage/library_paths.dart';

/// Minimal JPEG header; only the magic bytes matter for the archive code.
Uint8List fakeJpeg(int seed, {int size = 4096}) {
  final bytes = Uint8List(size);
  bytes[0] = 0xFF;
  bytes[1] = 0xD8;
  bytes[2] = 0xFF;
  bytes[3] = 0xE0;
  for (var index = 4; index < size; index++) {
    bytes[index] = (index + seed) & 0xFF;
  }
  return bytes;
}

void main() {
  group('ComicInfo', () {
    test('escapes XML and keeps Chinese text', () {
      const info = ComicInfo(
        series: 'A & B <测试>',
        number: 3,
        title: '第3话 "引号" & 撇号\'',
        summary: '简介 & <tag>',
        writer: '作者',
        genres: ['恋爱', '日常'],
        pageCount: 12,
      );
      final xml = info.toXml();
      expect(xml, contains('<Series>A &amp; B &lt;测试&gt;</Series>'));
      expect(xml, contains('&quot;引号&quot;'));
      expect(xml, contains('&apos;'));
      expect(xml, contains('<Genre>恋爱, 日常</Genre>'));
      expect(xml, contains('<PageCount>12</PageCount>'));
      expect(xml, contains('<Number>3</Number>'));
      expect(xml, contains('<LanguageISO>zh</LanguageISO>'));
      // No reading direction: guessing it wrong breaks page order in readers.
      expect(xml, isNot(contains('<Manga>')));
    });

    test('drops characters XML 1.0 forbids', () {
      expect(ComicInfo.escape('a\u0000b\u0001c'), 'abc');
      expect(ComicInfo.escape('tab\tnewline\n'), 'tab\tnewline\n');
    });

    test('falls back to a chapter number when the title is empty', () {
      const info = ComicInfo(series: 'S', number: 7, title: '');
      expect(info.toXml(), contains('<Title>第 7 话</Title>'));
    });
  });

  group('LibraryPaths', () {
    test('names chapters so Komga and Mihon sort them correctly', () {
      expect(
        LibraryPaths.chapterFileName(comicTitle: '测试:漫画', order: 3, episodeTitle: '第3话 深夜'),
        '测试_漫画 第003话 深夜.cbz',
      );
      expect(
        LibraryPaths.chapterFileName(comicTitle: '标题', order: 12, episodeTitle: '第12话'),
        '标题 第012话.cbz',
      );
    });

    test('rejects Windows-hostile titles', () {
      expect(LibraryPaths.sanitizeSegment('a/b\\c:d*e?f"g<h>i|j'), 'a_b_c_d_e_f_g_h_i_j');
      expect(LibraryPaths.sanitizeSegment('CON'), '_CON');
      expect(LibraryPaths.sanitizeSegment('   '), 'untitled');
      expect(LibraryPaths.sanitizeSegment('名字...'), '名字');
    });

    test('pads page numbers and compares them numerically', () {
      expect(LibraryPaths.pageName(0, 'jpg'), '001.jpg');
      expect(LibraryPaths.pageName(9, '.png', total: 12), '010.png');
      final names = ['010.jpg', '002.jpg', '001.jpg'];
      names.sort(LibraryPaths.naturalCompare);
      expect(names, ['001.jpg', '002.jpg', '010.jpg']);
    });
  });

  group('ComicArchive', () {
    late Directory temp;

    setUp(() async {
      temp = await Directory.systemTemp.createTemp('pica_cbz_test');
    });

    tearDown(() async {
      if (temp.existsSync()) await temp.delete(recursive: true);
    });

    test('packs pages and reads them back in order', () async {
      final pages = <String>[];
      for (var index = 0; index < 3; index++) {
        final file = File('${temp.path}${Platform.pathSeparator}page$index.jpg');
        await file.writeAsBytes(fakeJpeg(index));
        pages.add(file.path);
      }
      final target = '${temp.path}${Platform.pathSeparator}卷 第003话.cbz';
      final size = await ComicArchive.write(
        targetPath: target,
        pageFiles: pages,
        comicInfoXml: const ComicInfo(series: '卷', number: 3, title: '深夜').toXml(),
        notice: '仅供个人学习',
      );
      expect(size, File(target).lengthSync());
      // No leftover temp file after a successful pack.
      expect(File('$target.tmp').existsSync(), isFalse);

      final reader = ComicArchiveReader.open(target);
      addTearDown(reader.close);
      expect(reader.pageCount, 3);
      for (var index = 0; index < 3; index++) {
        expect(reader.pageBytes(index), fakeJpeg(index));
      }
      // Metadata never shows up as a page.
      expect(reader.nameAt(0), '001.jpg');
    });

    test('overwrites an existing archive (Windows cannot rename over it)', () async {
      final page = File('${temp.path}${Platform.pathSeparator}p.jpg');
      await page.writeAsBytes(fakeJpeg(1));
      final target = '${temp.path}${Platform.pathSeparator}a.cbz';
      await ComicArchive.write(
        targetPath: target,
        pageFiles: [page.path],
        comicInfoXml: const ComicInfo(series: 'A', number: 1, title: '一').toXml(),
      );
      await ComicArchive.write(
        targetPath: target,
        pageFiles: [page.path, page.path],
        comicInfoXml: const ComicInfo(series: 'A', number: 1, title: '一').toXml(),
      );
      final reader = ComicArchiveReader.open(target);
      addTearDown(reader.close);
      expect(reader.pageCount, 2);
    });

    test('refuses a chapter with no pages', () async {
      expect(
        () => ComicArchive.write(
          targetPath: '${temp.path}${Platform.pathSeparator}empty.cbz',
          pageFiles: const [],
          comicInfoXml: '',
        ),
        throwsArgumentError,
      );
    });

    test('reports a corrupt file instead of crashing', () async {
      final broken = File('${temp.path}${Platform.pathSeparator}broken.cbz');
      await broken.writeAsString('this is not a zip');
      expect(() => ComicArchiveReader.open(broken.path), throwsA(anything));
    });

    test('reports a missing file', () async {
      expect(
        () => ComicArchiveReader.open('${temp.path}${Platform.pathSeparator}nope.cbz'),
        throwsFormatException,
      );
    });
  });
}
