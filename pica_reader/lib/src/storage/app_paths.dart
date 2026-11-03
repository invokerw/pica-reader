import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

/// Writable directories for this app.
///
/// On Windows the first usable location out of `%APPDATA%`, `%LOCALAPPDATA%`,
/// `Documents`, the working directory and the system temp directory is used,
/// under a `pica_reader` subfolder. Probing matters because a locked-down
/// profile can deny writes to `%APPDATA%`; in that case the app must still start
/// instead of crashing during bootstrap.
///
/// On Android the app-private files directory is returned by a tiny
/// MethodChannel implemented in `MainActivity` (no plugin, so no symlink
/// requirement at build time).
class AppPaths {
  AppPaths._();

  static const MethodChannel _channel = MethodChannel('pica_reader/paths');
  static String? _cached;
  static bool _readOnly = false;

  /// True when no writable directory was found, so settings only live in
  /// memory for this session.
  static bool get isReadOnly => _readOnly;

  static Future<String> dataDir() async {
    final cached = _cached;
    if (cached != null) return cached;

    String? dir;
    if (Platform.isAndroid || Platform.isIOS) {
      dir = await _channel.invokeMethod<String>('getFilesDir') ?? '';
      if (dir.isEmpty) {
        throw StateError('无法获取应用私有目录');
      }
    } else {
      for (final candidate in _desktopCandidates()) {
        if (_usable(candidate)) {
          dir = candidate;
          break;
        }
      }
    }

    if (dir == null) {
      _readOnly = true;
      _cached = '';
      return '';
    }
    _cached = dir;
    return dir;
  }

  static List<String> _desktopCandidates() {
    final environment = Platform.environment;
    final separator = Platform.isWindows ? '\\' : '/';
    final bases = <String?>[
      environment['APPDATA'],
      environment['LOCALAPPDATA'],
      environment['HOME'],
    ].whereType<String>().where((value) => value.trim().isNotEmpty).toList();
    final home = environment['USERPROFILE'] ?? environment['HOME'];
    if (home != null && home.isNotEmpty) {
      bases.add('$home$separator' 'Documents');
    }
    bases.add(Directory.current.path);
    bases.add(Directory.systemTemp.path);
    final names = Platform.isWindows ? const ['pica_reader'] : const ['.pica_reader', 'pica_reader'];
    const vendor = 'local.pica';
    return [
      for (final base in bases)
        for (final name in names) '$base$separator$vendor$separator$name',
    ];
  }

  static bool _usable(String path) {
    try {
      final directory = Directory(path);
      if (!directory.existsSync()) directory.createSync(recursive: true);
      // Prove writability instead of trusting the ACL: create and remove a probe.
      final probe = File('$path${Platform.pathSeparator}.write-probe');
      probe.writeAsStringSync('ok', flush: true);
      probe.deleteSync();
      return true;
    } on FileSystemException {
      // PathAccessException (an ACL/SMB denial) is a FileSystemException too.
      return false;
    }
  }

  static Future<File?> file(String name) async {
    final dir = await dataDir();
    if (dir.isEmpty) return null;
    return File('$dir${Platform.pathSeparator}$name');
  }

  static Future<Map<String, dynamic>> readJson(String name) async {
    try {
      final handle = await file(name);
      if (handle == null || !handle.existsSync()) return <String, dynamic>{};
      final text = await handle.readAsString();
      if (text.trim().isEmpty) return <String, dynamic>{};
      final decoded = jsonDecode(text);
      return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
    } on FormatException {
      return <String, dynamic>{};
    } on FileSystemException {
      return <String, dynamic>{};
    }
  }

  /// Persisting is best effort: a read-only profile must never break the UI.
  static Future<bool> writeJson(String name, Map<String, dynamic> data) async {
    try {
      final handle = await file(name);
      if (handle == null) return false;
      final temporary = File('${handle.path}.tmp');
      await temporary.writeAsString(jsonEncode(data), flush: true);
      await temporary.rename(handle.path);
      return true;
    } on FileSystemException {
      _readOnly = true;
      return false;
    }
  }
}
