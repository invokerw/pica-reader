import 'package:flutter/foundation.dart';

import '../api/api_config.dart';
import '../api/models.dart';
import '../storage/app_paths.dart';

class Settings extends ChangeNotifier {
  String _imageQuality = ApiConfig.defaultImageQuality;
  String _sort = 'dd';
  int _columns = 0;
  bool _verticalReader = false;
  String _downloadRoot = '';
  int _downloadPages = 4;
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
}

/// Sort keys accepted by `GET /comics` (`s` parameter).
const Map<String, String> kSortLabels = {
  'dd': '默认排序',
  'da': '最新发布',
  'ld': '最多喜欢',
  'vd': '最多观看',
};
