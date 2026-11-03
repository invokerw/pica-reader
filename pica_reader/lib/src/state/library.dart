import 'dart:async';

import 'package:flutter/foundation.dart';

import '../api/models.dart';
import '../storage/app_paths.dart';

class ReadingProgress {
  const ReadingProgress({
    required this.order,
    required this.page,
    required this.comicTitle,
    required this.thumb,
    required this.updatedAt,
    this.totalPages = 0,
  });

  final int order;
  final int page;
  final String comicTitle;
  final String thumb;
  final int totalPages;
  final DateTime updatedAt;

  double get ratio => totalPages <= 0 ? 0 : ((page + 1) / totalPages).clamp(0, 1);

  Map<String, dynamic> toJson() => {
        'order': order,
        'page': page,
        'title': comicTitle,
        'thumb': thumb,
        'total': totalPages,
        'updatedAt': updatedAt.millisecondsSinceEpoch,
      };

  factory ReadingProgress.fromJson(Map<String, dynamic> json) => ReadingProgress(
        order: asInt(json['order']),
        page: asInt(json['page']),
        comicTitle: asString(json['title']),
        thumb: asString(json['thumb']),
        totalPages: asInt(json['total']),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(asInt(json['updatedAt'])),
      );
}

/// Local reading history and per-chapter progress. No account writes happen on
/// the server, so nothing here touches PICA state.
class Library extends ChangeNotifier {
  final Map<String, ReadingProgress> _progress = {};
  Timer? _saveTimer;

  List<MapEntry<String, ReadingProgress>> get history {
    final entries = _progress.entries.toList()
      ..sort((a, b) => b.value.updatedAt.compareTo(a.value.updatedAt));
    return entries;
  }

  ReadingProgress? progressOf(String comicId) => _progress[comicId];

  Future<void> load() async {
    final stored = await AppPaths.readJson('library.json');
    final items = stored['progress'];
    if (items is Map) {
      for (final entry in items.entries) {
        final value = asMap(entry.value);
        if (value.isEmpty) continue;
        _progress['${entry.key}'] = ReadingProgress.fromJson(value);
      }
    }
    notifyListeners();
  }

  void record({
    required String comicId,
    required String comicTitle,
    required String thumb,
    required int order,
    required int page,
    required int totalPages,
  }) {
    _progress[comicId] = ReadingProgress(
      order: order,
      page: page,
      comicTitle: comicTitle,
      thumb: thumb,
      totalPages: totalPages,
      updatedAt: DateTime.now(),
    );
    notifyListeners();
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 400), _save);
  }

  Future<void> clearHistory() async {
    _progress.clear();
    notifyListeners();
    await _save();
  }

  Future<void> _save() async {
    await AppPaths.writeJson('library.json', {
      'progress': {
        for (final entry in _progress.entries) entry.key: entry.value.toJson(),
      },
    });
  }
}
