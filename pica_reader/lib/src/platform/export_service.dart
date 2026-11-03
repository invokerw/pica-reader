import 'dart:io';

import 'package:flutter/services.dart';

/// Moves a downloaded chapter out of the app sandbox.
///
/// On Android the app-private files directory is invisible to other apps, so a
/// CBZ is only useful once it reaches the shared `Download` folder. The export
/// goes through MediaStore (API 29+), which needs no runtime permission at all;
/// Android 7–9 fall back to the app's external files folder, also permission
/// free.
///
/// On desktop the library already lives in a normal folder, so "export" just
/// copies the file to `Downloads`.
class ExportService {
  ExportService._();

  static const MethodChannel _channel = MethodChannel('pica_reader/paths');

  /// [relativeName] is the path inside the export folder, e.g.
  /// `漫画标题/漫画标题 第003话.cbz`. Returns the exported URI/path, or `''`.
  static Future<String> exportChapter({
    required String path,
    required String relativeName,
  }) async {
    if (Platform.isAndroid || Platform.isIOS) {
      final result = await _channel.invokeMethod<String>('exportToDownloads', {
        'path': path,
        'name': relativeName,
      });
      return result ?? '';
    }
    final target = _uniqueTarget(_desktopDownloads(), relativeName);
    await target.parent.create(recursive: true);
    await File(path).copy(target.path);
    return target.path;
  }

  static Future<void> revealInExplorer(String path) async {
    if (!Platform.isWindows) {
      await openFolder(File(path).parent.path);
      return;
    }
    try {
      await Process.start('explorer.exe', ['/select,', path]);
    } on ProcessException {
      // Explorer is optional; failing to open it must not crash the action.
    }
  }

  static Future<void> openFolder(String path) async {
    try {
      if (Platform.isWindows) {
        await Process.start('explorer.exe', [path]);
      } else if (Platform.isMacOS) {
        await Process.start('open', [path]);
      } else if (Platform.isLinux) {
        await Process.start('xdg-open', [path]);
      }
    } on ProcessException {
      // No file manager available (headless session).
    }
  }

  static String _desktopDownloads() {
    final separator = Platform.pathSeparator;
    final home = Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'];
    if (home != null && home.isNotEmpty) {
      return '$home${separator}Downloads';
    }
    return Directory.systemTemp.path;
  }

  static File _uniqueTarget(String root, String relativeName) {
    final separator = Platform.pathSeparator;
    final normalized = relativeName.replaceAll('/', separator);
    final file = File('$root$separator$normalized');
    if (!file.existsSync()) return file;
    final dot = file.path.lastIndexOf('.');
    final stem = dot < 0 ? file.path : file.path.substring(0, dot);
    final extension = dot < 0 ? '' : file.path.substring(dot);
    for (var copy = 2; copy < 1000; copy++) {
      final candidate = File('$stem ($copy)$extension');
      if (!candidate.existsSync()) return candidate;
    }
    return file;
  }
}
