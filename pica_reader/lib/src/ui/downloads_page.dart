import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../api/models.dart';
import '../platform/export_service.dart';
import '../state/downloads.dart';
import '../storage/library_paths.dart';
import 'reader_page.dart';
import 'widgets/comic_card.dart';
import 'widgets/pica_image.dart';

/// The offline library: everything downloaded, plus export/delete controls.
class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final downloads = context.watch<DownloadManager>();
    final comics = downloads.comics;

    return Scaffold(
      appBar: AppBar(
        title: const Text('离线漫画'),
        actions: [
          if (downloads.pendingCount > 0)
            IconButton(
              tooltip: downloads.isPaused ? '继续下载' : '全部暂停',
              onPressed: () =>
                  downloads.isPaused ? downloads.resumeAll() : downloads.pauseAll(),
              icon: Icon(downloads.isPaused ? Icons.play_arrow : Icons.pause),
            ),
        ],
      ),
      body: comics.isEmpty
          ? const EmptyState(message: '还没有离线章节\n在漫画详情页点章节右侧的下载按钮')
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: comics.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return _StorageHeader(downloads: downloads);
                final comic = comics[index - 1];
                return _ComicGroup(comic: comic, downloads: downloads);
              },
            ),
    );
  }
}

class _StorageHeader extends StatelessWidget {
  const _StorageHeader({required this.downloads});

  final DownloadManager downloads;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.sd_storage_outlined, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 6),
                Text(
                  '${downloads.totalChapters} 话 · ${formatBytes(downloads.totalBytes)}',
                  style: theme.textTheme.titleSmall,
                ),
                const Spacer(),
                if (downloads.pendingCount > 0)
                  Text(
                    '${downloads.pendingCount} 话在队列',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.outline),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            SelectableText(
              downloads.rootPath.isEmpty ? '未找到可写目录' : downloads.rootPath,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                TextButton.icon(
                  onPressed: downloads.rootPath.isEmpty
                      ? null
                      : () => ExportService.openFolder(downloads.rootPath),
                  icon: const Icon(Icons.folder_open, size: 18),
                  label: const Text('打开文件夹'),
                ),
                const Spacer(),
                Text(
                  Platform.isAndroid ? '导出到系统「下载」' : 'CBZ 格式，可直接给 Komga / Mihon 用',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ComicGroup extends StatelessWidget {
  const _ComicGroup({required this.comic, required this.downloads});

  final ComicDownload comic;
  final DownloadManager downloads;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpansionTile(
      initiallyExpanded: comic.hasWork,
      leading: SizedBox(
        width: 42,
        height: 56,
        child: PicaImage(
          url: comic.thumb,
          cacheWidth: 180,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      title: Text(comic.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${comic.downloadedCount}/${comic.chapters.length} 话 · ${formatBytes(comic.bytes)}',
        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
      ),
      childrenPadding: const EdgeInsets.only(bottom: 8),
      children: [
        for (final chapter in comic.sortedChapters)
          _ChapterTile(comic: comic, chapter: chapter, downloads: downloads),
        Padding(
          padding: const EdgeInsets.only(left: 72, right: 16),
          child: Row(
            children: [
              TextButton.icon(
                onPressed: () => _exportComic(context),
                icon: const Icon(Icons.ios_share, size: 18),
                label: const Text('全部导出'),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _deleteComic(context),
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('删除整部'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _exportComic(BuildContext context) async {
    var exported = 0;
    for (final chapter in comic.sortedChapters) {
      if (await _exportOne(context, downloads, comic, chapter)) exported += 1;
    }
    if (!context.mounted) return;
    _toast(context, exported == 0 ? '没有可导出的章节' : '已导出 $exported 话');
  }

  Future<void> _deleteComic(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除整部漫画？'),
        content: Text('会删除《${comic.title}》的 ${comic.downloadedCount} 个已下载章节文件。'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('取消')),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('删除')),
        ],
      ),
    );
    if (confirmed == true) await downloads.removeComic(comic.id);
  }
}

class _ChapterTile extends StatelessWidget {
  const _ChapterTile({
    required this.comic,
    required this.chapter,
    required this.downloads,
  });

  final ComicDownload comic;
  final ChapterDownload chapter;
  final DownloadManager downloads;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(left: 72, right: 8),
      leading: SizedBox(
        width: 28,
        child: Center(child: _leadingIcon(theme)),
      ),
      title: Text(
        _chapterLabel(chapter),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(_subtitle(theme), maxLines: 2, overflow: TextOverflow.ellipsis),
      onTap: chapter.isDone ? () => _open(context) : null,
      trailing: PopupMenuButton<String>(
        tooltip: '更多',
        onSelected: (value) => _onAction(context, value),
        itemBuilder: (context) => [
          if (chapter.isDone) const PopupMenuItem(value: 'read', child: Text('阅读')),
          if (chapter.isDone) const PopupMenuItem(value: 'export', child: Text('导出')),
          if (chapter.isFailed) const PopupMenuItem(value: 'retry', child: Text('重试')),
          if (chapter.isRunning || chapter.isQueued)
            const PopupMenuItem(value: 'pause', child: Text('暂停')),
          if (chapter.isPaused) const PopupMenuItem(value: 'resume', child: Text('继续')),
          const PopupMenuItem(value: 'delete', child: Text('删除')),
        ],
      ),
    );
  }

  Widget _leadingIcon(ThemeData theme) {
    return switch (chapter.state) {
      ChapterState.done => Icon(Icons.check_circle, size: 20, color: theme.colorScheme.primary),
      ChapterState.failed => Icon(Icons.error_outline, size: 20, color: theme.colorScheme.error),
      ChapterState.paused => const Icon(Icons.pause_circle_outline, size: 20),
      ChapterState.queued => const Icon(Icons.schedule, size: 20),
      ChapterState.running => SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(value: chapter.progress, strokeWidth: 2),
        ),
    };
  }

  String _subtitle(ThemeData theme) {
    final size = formatBytes(chapter.bytes);
    return switch (chapter.state) {
      ChapterState.done => '${chapter.totalPages} 页 · $size',
      ChapterState.running => chapter.totalPages > 0
          ? '下载中 ${chapter.pagesDone}/${chapter.totalPages} · ${(chapter.progress * 100).round()}%'
          : '正在获取图片列表…',
      ChapterState.queued => '排队中',
      ChapterState.paused => chapter.totalPages > 0
          ? '已暂停 ${chapter.pagesDone}/${chapter.totalPages}'
          : '已暂停',
      ChapterState.failed => chapter.error.isEmpty ? '下载失败' : chapter.error,
    };
  }

  void _open(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ReaderPage(
        comicId: comic.id,
        comicTitle: comic.title,
        thumb: comic.thumb,
        episode: Episode(id: '', title: chapter.title, order: chapter.order),
      ),
    ));
  }

  Future<void> _onAction(BuildContext context, String action) async {
    switch (action) {
      case 'read':
        _open(context);
      case 'export':
        final ok = await _exportOne(context, downloads, comic, chapter);
        if (ok && context.mounted) _toast(context, '已导出');
      case 'retry':
        await downloads.retry(chapter);
      case 'pause':
        downloads.pauseChapter(chapter);
      case 'resume':
        downloads.resumeChapter(chapter);
      case 'delete':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('删除这一话？'),
            content: Text('会删除本地文件：${_chapterLabel(chapter)}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('删除'),
              ),
            ],
          ),
        );
        if (confirmed == true) await downloads.removeChapter(comic.id, chapter.order);
    }
  }

  static String _chapterLabel(ChapterDownload chapter) {
    final cleaned = LibraryPaths.cleanEpisodeTitle(chapter.title, chapter.order);
    return cleaned.isEmpty ? '第 ${chapter.order} 话' : '第 ${chapter.order} 话 · $cleaned';
  }
}

Future<bool> _exportOne(
  BuildContext context,
  DownloadManager downloads,
  ComicDownload comic,
  ChapterDownload chapter,
) async {
  final path = downloads.localPathOf(comic.id, chapter.order);
  if (path == null) {
    if (context.mounted) _toast(context, '本地文件不存在');
    return false;
  }
  final fileName = path.split(Platform.pathSeparator).last;
  final relative = '${LibraryPaths.sanitizeSegment(comic.title)}/$fileName';
  try {
    final result = await ExportService.exportChapter(path: path, relativeName: relative);
    if (result.isEmpty) {
      if (context.mounted) _toast(context, '导出失败');
      return false;
    }
    if (!Platform.isAndroid && !Platform.isIOS) {
      await ExportService.revealInExplorer(result);
    }
    return true;
  } on PlatformException catch (error) {
    if (context.mounted) _toast(context, '导出失败：${error.message ?? error.code}');
    return false;
  } on FileSystemException catch (error) {
    if (context.mounted) _toast(context, '导出失败：${error.message}');
    return false;
  }
}

void _toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
