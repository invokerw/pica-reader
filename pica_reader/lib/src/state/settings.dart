import 'package:flutter/material.dart';

import '../api/api_config.dart';
import '../api/models.dart';
import '../storage/app_paths.dart';
import '../theme/app_themes.dart';

class Settings extends ChangeNotifier {
  String _imageQuality = ApiConfig.defaultImageQuality;
  String _sort = 'dd';
  int _columns = 0;
  bool _verticalReader = false;
  String _downloadRoot = '';
  int _downloadPages = 4;
  String _themeId = kDefaultThemeId;
  ThemeMode _themeMode = ThemeMode.system;
  bool _loaded = false;

  String get imageQuality => _imageQuality;
  String get sort => _sort;
  int get columns => _columns;
  bool get verticalReader => _verticalReader;

  /// Empty means "the platform default" (`LibraryPaths.defaultRoot`).
  String get downloadRoot => _downloadRoot;

  /// Page requests running in parallel inside one chapter.
  int get downloadPages => _downloadPages;
  bool get loaded => _loaded;

  String get themeId => _themeId;
  ThemeMode get themeMode => _themeMode;

  Future<void> load() async {
    final stored = await AppPaths.readJson('settings.json');
    final quality = asString(stored['imageQuality']);
    if (ApiConfig.imageQualities.contains(quality)) _imageQuality = quality;
    final sort = asString(stored['sort']);
    if (sort.isNotEmpty) _sort = sort;
    _columns = asInt(stored['columns']);
    _verticalReader = asBool(stored['verticalReader']);
    _downloadRoot = asString(stored['downloadRoot']);
    final pages = asInt(stored['downloadPages'], 4);
    _downloadPages = pages < 1 ? 4 : pages.clamp(1, 8);
    final themeId = asString(stored['themeId']);
    if (themeId.isNotEmpty) _themeId = themeId;
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
        'verticalReader': _verticalReader,
        'downloadRoot': _downloadRoot,
        'downloadPages': _downloadPages,
        'themeId': _themeId,
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

  void setVerticalReader(bool value) {
    if (value == _verticalReader) return;
    _verticalReader = value;
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
}

/// Sort keys accepted by `GET /comics` (`s` parameter).
const Map<String, String> kSortLabels = {
  'dd': '默认排序',
  'da': '最新发布',
  'ld': '最多喜欢',
  'vd': '最多观看',
};
