import 'dart:io';

import 'app_paths.dart';

/// Where downloaded chapters live and how they are named.
///
/// The layout is the one local comic readers expect, so the folder can be
/// pointed at by Mihon's local source, Komga or Kavita without renaming:
///
/// ```
/// <root>/<comic title>/<comic title> 第003话 <chapter title>.cbz
/// <root>/index.json                    full manifest
/// <root>/.part/<comicId>/<order>/      pages while a chapter downloads
/// ```
class LibraryPaths {
  LibraryPaths._();

  static const String manifestName = 'index.json';
  static const String partDirName = '.part';
  static const String noticeName = '来源说明.txt';
  static const String comicInfoName = 'ComicInfo.xml';

  static String get _separator => Platform.pathSeparator;

  /// `Downloads` is the default on desktop: a downloaded library is user data
  /// that belongs next to the user's other files, not in the roaming profile
  /// (`%APPDATA%`), which Windows copies between machines — six gigabytes of
  /// comics there would be a disaster.
  ///
  /// Android is sandboxed, so the app-private directory is the only place
  /// available without permissions; `ExportService` copies chosen chapters to
  /// the public `Download` folder.
  static Future<String> defaultRoot() async {
    final separator = _separator;
    if (!Platform.isAndroid && !Platform.isIOS) {
      final home = Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'];
      if (home != null && home.isNotEmpty) {
        final candidate =
            '$home${separator}Documents${separator}local.pica${separator}pica_reader${separator}downloads';
        if (_ensure(candidate)) return candidate;
      }
      final local = Platform.environment['LOCALAPPDATA'];
      if (local != null && local.isNotEmpty) {
        final candidate =
            '$local${separator}local.pica${separator}pica_reader${separator}downloads';
        if (_ensure(candidate)) return candidate;
      }
    }
    final data = await AppPaths.dataDir();
    if (data.isEmpty) return '';
    final fallback = '$data${separator}downloads';
    return _ensure(fallback) ? fallback : '';
  }

  /// Honours a user-chosen folder and silently falls back to the default when
  /// it is gone (unplugged drive, deleted folder).
  static Future<String> resolveRoot(String override) async {
    final trimmed = override.trim();
    if (trimmed.isNotEmpty && _ensure(trimmed)) return trimmed;
    return defaultRoot();
  }

  static bool _ensure(String path) {
    try {
      final directory = Directory(path);
      if (!directory.existsSync()) directory.createSync(recursive: true);
      final probe = File('$path$_separator.write-probe');
      probe.writeAsStringSync('ok', flush: true);
      probe.deleteSync();
      return true;
    } on FileSystemException {
      return false;
    }
  }

  /// Makes a string safe as a single path segment on Windows, macOS and Linux.
  ///
  /// Comic titles routinely carry `?`, `:` or `/`, and Windows rejects those
  /// outright — and reserved device names (`CON`, `NUL`, …) even with an
  /// extension. Nothing here is cosmetic: an unsanitised name fails the write.
  static String sanitizeSegment(
    String value, {
    String fallback = 'untitled',
    int maxLength = 48,
  }) {
    var text = value.replaceAll(RegExp(r'[\x00-\x1F\x7F<>:"/\\|?*]'), '_');
    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    // Windows also drops trailing dots and spaces before the extension.
    text = text.replaceAll(RegExp(r'[. ]+$'), '');
    text = text.replaceAll(RegExp(r'^[. ]+'), '');
    if (text.isEmpty) return fallback;
    const reserved = {
      'CON', 'PRN', 'AUX', 'NUL', //
      'COM1', 'COM2', 'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9',
      'LPT1', 'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8', 'LPT9',
    };
    final stem = text.split('.').first.toUpperCase();
    if (reserved.contains(stem)) text = '_$text';
    final runes = text.runes.toList();
    if (runes.length > maxLength) {
      text = String.fromCharCodes(runes.take(maxLength)).trim();
      if (text.isEmpty) return fallback;
    }
    return text;
  }

  /// Removes a leading `第 12 话` from a chapter title.
  ///
  /// The API usually sends `第 3 話` or `第3话 深夜` as the title, while the file
  /// name already carries the number; keeping both reads as `第003话 第 3 話`.
  static String cleanEpisodeTitle(String title, int order) {
    var text = title.trim();
    text = text.replaceFirst(
      RegExp(r'^\s*第\s*[0-9零一二三四五六七八九十百千两]+\s*[话話集回章節节]?\s*[·:：\-—]?\s*'),
      '',
    );
    // A bare `第 N 话` (the placeholder the API uses for untitled chapters).
    if (RegExp(r'^[\s·:：\-—]*$').hasMatch(text)) return '';
    return text.trim();
  }

  /// `漫画标题 第003话 章节标题.cbz`, the name Mihon/Komga expect.
  static String chapterFileName({
    required String comicTitle,
    required int order,
    required String episodeTitle,
  }) {
    final comic = sanitizeSegment(comicTitle, fallback: '漫画');
    final tail = sanitizeSegment(
      cleanEpisodeTitle(episodeTitle, order),
      fallback: '',
      maxLength: 40,
    );
    final number = order.toString().padLeft(3, '0');
    final suffix = tail.isEmpty ? '' : ' $tail';
    return '$comic 第$number话$suffix.cbz';
  }

  /// Zero-padded page name so every sorter (and `strcmp`) keeps the order.
  static String pageName(int index, String extension, {int total = 0}) {
    final width = total >= 1000 ? 4 : 3;
    final stem = (index + 1).toString().padLeft(width, '0');
    final ext = extension.startsWith('.') ? extension.substring(1) : extension;
    return ext.isEmpty ? stem : '$stem.$ext';
  }

  /// Numeric-aware comparison: `002.jpg` sorts before `010.jpg`.
  static int naturalCompare(String a, String b) {
    var i = 0;
    var j = 0;
    while (i < a.length && j < b.length) {
      final ca = a.codeUnitAt(i);
      final cb = b.codeUnitAt(j);
      final digitA = ca >= 0x30 && ca <= 0x39;
      final digitB = cb >= 0x30 && cb <= 0x39;
      if (digitA && digitB) {
        final startA = i;
        final startB = j;
        while (i < a.length && _isDigit(a.codeUnitAt(i))) {
          i++;
        }
        while (j < b.length && _isDigit(b.codeUnitAt(j))) {
          j++;
        }
        final numberA = int.tryParse(a.substring(startA, i)) ?? 0;
        final numberB = int.tryParse(b.substring(startB, j)) ?? 0;
        if (numberA != numberB) return numberA.compareTo(numberB);
      } else {
        if (ca != cb) return ca.compareTo(cb);
        i++;
        j++;
      }
    }
    return (a.length - i).compareTo(b.length - j);
  }

  static bool _isDigit(int codeUnit) => codeUnit >= 0x30 && codeUnit <= 0x39;
}
