import 'package:flutter/widgets.dart';

import '../api/api_config.dart';
import '../storage/comic_archive.dart';
import 'widgets/cbz_page_image.dart';

/// Where the pages of the chapter being read come from.
///
/// The reader only needs "how many pages" and "give me page N", so a downloaded
/// chapter and a streamed one behave identically above this line.
abstract class ChapterSource {
  int get length;

  ImageProvider imageAt(int index);

  /// True when the pages come from a file on disk, so the UI can say so.
  bool get isLocal;

  void dispose();
}

class RemoteChapter extends ChapterSource {
  RemoteChapter(this.urls);

  final List<String> urls;

  @override
  int get length => urls.length;

  @override
  bool get isLocal => false;

  @override
  ImageProvider imageAt(int index) => NetworkImage(
        urls[index],
        headers: const {'User-Agent': ApiConfig.userAgent},
      );

  @override
  void dispose() {}
}

class LocalChapter extends ChapterSource {
  LocalChapter._(this.path, this._archive);

  final String path;
  final ComicArchiveReader _archive;

  static LocalChapter open(String path) =>
      LocalChapter._(path, ComicArchiveReader.open(path));

  @override
  int get length => _archive.pageCount;

  @override
  bool get isLocal => true;

  @override
  ImageProvider imageAt(int index) => CbzPageImage(_archive, index);

  @override
  void dispose() => _archive.close();
}
