import 'package:flutter/material.dart';

import '../api/api_config.dart';
import '../api/models.dart';
import '../storage/app_paths.dart';
import '../theme/app_themes.dart';

class Settings extends ChangeNotifier {
  String _imageQuality = ApiConfig.defaultImageQuality;
  String _sort = 'dd';
  int _columns = 0;
  ReaderMode _readerMode = ReaderMode.horizontal;
  String _downloadRoot = '';
  int _downloadPages = 4;
  String _themeId = kDefaultThemeId;
  ThemeMode _themeMode = ThemeMode.system;

  /// Whether the detail page lists the newest chapter first, which is how the
  /// API hands them over.
  bool _chapterDescending = true;
  bool _loaded = false;

  String get imageQuality => _imageQuality;
  String get sort => _sort;
  int get columns => _columns;
  ReaderMode get readerMode => _readerMode;

  /// Empty means "the platform default" (`LibraryPaths.defaultRoot`).
  String get downloadRoot => _downloadRoot;

  /// Page requests running in parallel inside one chapter.
  int get downloadPages => _downloadPages;
  bool get loaded => _loaded;

  String get themeId => _themeId;
  ThemeMode get themeMode => _themeMode;
  bool get chapterDescending => _chapterDescending;

  Future<void> load() async {
    final stored = await AppPaths.readJson('settings.json');
    final quality = asString(stored['imageQuality']);
    if (ApiConfig.imageQualities.contains(quality)) _imageQuality = quality;
    final sort = asString(stored['sort']);
    if (sort.isNotEmpty) _sort = sort;
    _columns = asInt(stored['columns']);
    // `readerMode` replaced the old boolean. Someone who had vertical paging on
    // was asking for downward reading, which is now the continuous strip.
    final modeName = asString(stored['readerMode']);
    _readerMode = _modeByName(modeName) ??
        (asBool(stored['verticalReader'])
            ? ReaderMode.continuous
            : ReaderMode.horizontal);
    _downloadRoot = asString(stored['downloadRoot']);
    final pages = asInt(stored['downloadPages'], 4);
    _downloadPages = pages < 1 ? 4 : pages.clamp(1, 8);
    final themeId = asString(stored['themeId']);
    if (themeId.isNotEmpty) _themeId = themeId;
    _chapterDescending = asBool(stored['chapterDesc'], true);
    final mode = asString(stored['themeMode']);
    if (mode.isNotEmpty) {
      _themeMode = switch (mode) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> _persist() => AppPaths.writeJson('settings.json', {
        'imageQuality': _imageQuality,
        'sort': _sort,
        'columns': _columns,
        'readerMode': _readerMode.name,
        'downloadRoot': _downloadRoot,
        'downloadPages': _downloadPages,
        'themeId': _themeId,
        'chapterDesc': _chapterDescending,
        'themeMode': switch (_themeMode) {
          ThemeMode.light => 'light',
          ThemeMode.dark => 'dark',
          _ => 'system',
        },
      });

  void setImageQuality(String value) {
    if (!ApiConfig.imageQualities.contains(value) || value == _imageQuality) return;
    _imageQuality = value;
    notifyListeners();
    _persist();
  }

  void setSort(String value) {
    if (value == _sort) return;
    _sort = value;
    notifyListeners();
    _persist();
  }

  void setColumns(int value) {
    if (value == _columns) return;
    _columns = value;
    notifyListeners();
    _persist();
  }

  void setReaderMode(ReaderMode value) {
    if (value == _readerMode) return;
    _readerMode = value;
    notifyListeners();
    _persist();
  }

  void setDownloadRoot(String value) {
    final trimmed = value.trim();
    if (trimmed == _downloadRoot) return;
    _downloadRoot = trimmed;
    notifyListeners();
    _persist();
  }

  void setDownloadPages(int value) {
    final clamped = value.clamp(1, 8);
    if (clamped == _downloadPages) return;
    _downloadPages = clamped;
    notifyListeners();
    _persist();
  }

  void setTheme(String value) {
    if (value == _themeId) return;
    _themeId = value;
    notifyListeners();
    _persist();
  }

  void setThemeMode(ThemeMode value) {
    if (value == _themeMode) return;
    _themeMode = value;
    notifyListeners();
    _persist();
  }

  void setChapterDescending(bool value) {
    if (value == _chapterDescending) return;
    _chapterDescending = value;
    notifyListeners();
    _persist();
  }
}

/// How the reader turns pages.
enum ReaderMode {
  /// One page per screen, paged sideways.
  horizontal('横向翻页'),

  /// One page per screen, paged up and down.
  vertical('纵向翻页'),

  /// Pages stacked top to bottom, scrolled freely (webtoon / long strip).
  continuous('纵向连续');

  const ReaderMode(this.label);

  final String label;
}

ReaderMode? _modeByName(String name) {
  for (final mode in ReaderMode.values) {
    if (mode.name == name) return mode;
  }
  return null;
}

/// Sort keys accepted by `GET /comics` (`s` parameter).
const Map<String, String> kSortLabels = {
  'dd': '默认排序',
  'da': '最新发布',
  'ld': '最多喜欢',
  'vd': '最多观看',
};
