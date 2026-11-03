import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';

import 'library_paths.dart';

/// Writes and reads CBZ files (zip archives holding the page images).
///
/// A CBZ is an ordinary ZIP: the pages are stored **uncompressed** (`STORE`)
/// because JPEG/PNG are already compressed — deflate would only burn CPU and
/// add a few bytes. The metadata files stay deflated since they are text.
///
/// Files are written to `<target>.tmp` first and renamed afterwards, so a killed
/// download can never leave a half-written archive that a comic reader would
/// happily open and show as a broken chapter.
class ComicArchive {
  ComicArchive._();

  static const List<String> imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];

  /// Packs [pageFiles] (already downloaded, in reading order) into [targetPath].
  ///
  /// Returns the size of the finished archive in bytes.
  static Future<int> write({
    required String targetPath,
    required List<String> pageFiles,
    required String comicInfoXml,
    String? notice,
    void Function(int done, int total)? onProgress,
  }) async {
    if (pageFiles.isEmpty) {
      throw ArgumentError.value(pageFiles, 'pageFiles', '空章节不能打包');
    }
    final target = File(targetPath);
    await target.parent.create(recursive: true);
    final temporary = File('$targetPath.tmp');
    if (temporary.existsSync()) temporary.deleteSync();

    final encoder = ZipFileEncoder();
    encoder.create(temporary.path);
    try {
      final total = pageFiles.length;
      for (var index = 0; index < total; index++) {
        final page = File(pageFiles[index]);
        if (!page.existsSync() || page.lengthSync() == 0) {
          throw StateError('第 ${index + 1} 页缺失，无法打包');
        }
        final extension = _extensionOf(page.path);
        await encoder.addFile(
          page,
          LibraryPaths.pageName(index, extension, total: total),
          ArchiveFile.STORE,
        );
        onProgress?.call(index + 1, total);
      }
      _addText(encoder, LibraryPaths.comicInfoName, comicInfoXml);
      if (notice != null && notice.trim().isNotEmpty) {
        _addText(encoder, LibraryPaths.noticeName, notice);
      }
      await encoder.close();
    } catch (_) {
      if (temporary.existsSync()) {
        try {
          temporary.deleteSync();
        } on FileSystemException {
          // Leaving a stale .tmp behind is harmless; the error matters more.
        }
      }
      rethrow;
    }

    // rename() cannot replace an existing file on Windows.
    if (target.existsSync()) target.deleteSync();
    await temporary.rename(targetPath);
    return target.lengthSync();
  }

  static void _addText(ZipFileEncoder encoder, String name, String text) {
    // utf8, not code units: ComicInfo.xml and the notice are Chinese.
    final bytes = Uint8List.fromList(utf8.encode(text));
    encoder.addArchiveFile(ArchiveFile(name, bytes.length, bytes));
  }

  static String _extensionOf(String path) {
    final dot = path.lastIndexOf('.');
    if (dot < 0 || dot == path.length - 1) return 'jpg';
    final extension = path.substring(dot + 1).toLowerCase();
    return imageExtensions.contains(extension) ? extension : 'jpg';
  }
}

/// Lazy reader for a CBZ, used by the offline reader.
///
/// Only the zip central directory is read up front; a page is inflated when it
/// is displayed, so opening a 60 MB chapter costs milliseconds and a few
/// kilobytes of memory.
class ComicArchiveReader {
  ComicArchiveReader._(this.path, this._stream, this._pages);

  final String path;
  final InputFileStream _stream;
  final List<ArchiveFile> _pages;
  bool _closed = false;

  /// Throws [FormatException] when the file is not a usable comic archive.
  static ComicArchiveReader open(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      throw FormatException('文件不存在：$path');
    }
    final InputFileStream stream;
    try {
      stream = InputFileStream(path);
    } on FileSystemException catch (error) {
      throw FormatException('无法打开文件：${error.message}');
    }
    try {
      final archive = ZipDecoder().decodeBuffer(stream);
      final pages = <ArchiveFile>[];
      for (final entry in archive.files) {
        if (!entry.isFile) continue;
        final name = entry.name;
        // Never expose ComicInfo.xml / 来源说明.txt as pages.
        if (name.contains('/')) continue;
        final dot = name.lastIndexOf('.');
        if (dot < 0) continue;
        final extension = name.substring(dot + 1).toLowerCase();
        if (!ComicArchive.imageExtensions.contains(extension)) continue;
        pages.add(entry);
      }
      pages.sort((a, b) => LibraryPaths.naturalCompare(a.name, b.name));
      if (pages.isEmpty) {
        stream.closeSync();
        throw const FormatException('压缩包内没有图片');
      }
      return ComicArchiveReader._(path, stream, pages);
    } catch (_) {
      try {
        stream.closeSync();
      } on FileSystemException {
        // Already failing; the original error is the useful one.
      }
      rethrow;
    }
  }

  int get pageCount => _pages.length;

  String nameAt(int index) => _pages[index].name;

  /// Raw encoded bytes of one page (JPEG/PNG/…), inflated on demand.
  Uint8List pageBytes(int index) {
    if (_closed) throw StateError('压缩包已关闭');
    if (index < 0 || index >= _pages.length) {
      throw RangeError.index(index, _pages, 'index');
    }
    final content = _pages[index].content;
    if (content is Uint8List) return content;
    if (content is List<int>) return Uint8List.fromList(content);
    throw FormatException('无法读取第 ${index + 1} 页');
  }

  void close() {
    if (_closed) return;
    _closed = true;
    _pages.clear();
    _stream.closeSync();
  }
}
