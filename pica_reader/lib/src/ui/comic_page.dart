import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/models.dart';
import '../platform/export_service.dart';
import '../state/downloads.dart';
import '../state/library.dart';
import '../state/settings.dart';
import '../storage/library_paths.dart';
import 'chapter_order.dart';
import 'reader_page.dart';
import 'widgets/comic_card.dart';
import 'widgets/pica_image.dart';

class ComicDetailPage extends StatefulWidget {
  const ComicDetailPage({super.key, required this.comic});

  final Comic comic;

  @override
  State<ComicDetailPage> createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicDetailPage> {
  late Comic _comic = widget.comic;
  List<Episode> _episodes = const [];
  int _episodePage = 0;
  int _episodeTotal = 0;
  bool _loading = true;
  bool _loadingMore = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final api = context.read<ApiClient>();
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final detail = await api.comic(widget.comic.id);
      final episodes = await api.episodes(widget.comic.id);
      if (!mounted) return;
      setState(() {
        _comic = detail.isUsable ? detail : widget.comic;
        _episodes = episodes.docs;
        _episodePage = episodes.page;
        _episodeTotal = episodes.total;
      });
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _loadMoreEpisodes() async {
    if (_loadingMore) return;
    setState(() => _loadingMore = true);
    try {
      final paged = await context
          .read<ApiClient>()
          .episodes(widget.comic.id, page: _episodePage + 1);
      if (!mounted) return;
      setState(() {
        _episodes = [..._episodes, ...paged.docs];
        _episodePage = paged.page == 0 ? _episodePage + 1 : paged.page;
        _episodeTotal = paged.total;
      });
    } on ApiException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message)));
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  void _open(Episode episode) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ReaderPage(
        comicId: _comic.id,
        comicTitle: _comic.title,
        thumb: _comic.thumb,
        episode: episode,
      ),
    ));
  }

  Episode? _resumeEpisode(ReadingProgress? progress) {
    if (progress == null) return null;
    for (final episode in _episodes) {
      if (episode.order == progress.order) return episode;
    }
    return Episode(id: '', title: '第 ${progress.order} 话', order: progress.order);
  }

  /// The API hands chapters over newest first; flipping the list is a view
  /// concern, so the loaded list itself stays as it came from paging.
  List<Episode> _ordered(bool descending) =>
      orderEpisodes(_episodes, descending: descending);

  /// Where "开始阅读" goes when nothing has been read yet: the earliest chapter.
  Episode? get _firstEpisode {
    Episode? first;
    for (final episode in _episodes) {
      if (first == null || episode.order < first.order) first = episode;
    }
    return first;
  }

  Future<void> _download(Episode episode) async {
    await context.read<DownloadManager>().enqueue(comic: _comic, episode: episode);
    if (!mounted) return;
    _toast('已加入下载队列：${episode.title}');
  }

  Future<void> _downloadAll(DownloadManager downloads) async {
    if (_episodes.isEmpty) return;
    // Queue from chapter one onwards regardless of how the list is displayed.
    final ordered = _ordered(false);
    await downloads.enqueueAll(comic: _comic, episodes: ordered);
    if (!mounted) return;
    final more = _episodes.length < _episodeTotal;
    _toast(more
        ? '已排队 ${ordered.length} 话（还有章节未加载，可加载后再下载）'
        : '已排队 ${ordered.length} 话');
  }

  Future<void> _openDownloadedMenu(Episode episode) async {
    final downloads = context.read<DownloadManager>();
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (sheet) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('阅读（离线）'),
              onTap: () => Navigator.of(sheet).pop('read'),
            ),
            ListTile(
              leading: const Icon(Icons.ios_share),
              title: Text(Platform.isAndroid ? '导出到系统「下载」' : '导出到「下载」文件夹'),
              onTap: () => Navigator.of(sheet).pop('export'),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('删除下载'),
              onTap: () => Navigator.of(sheet).pop('delete'),
            ),
          ],
        ),
      ),
    );
    if (!mounted || action == null) return;
    switch (action) {
      case 'read':
        _open(episode);
      case 'export':
        await _export(episode, downloads);
      case 'delete':
        await downloads.removeChapter(_comic.id, episode.order);
    }
  }

  Future<void> _export(Episode episode, DownloadManager downloads) async {
    final path = downloads.localPathOf(_comic.id, episode.order);
    if (path == null) {
      _toast('本地文件不存在');
      return;
    }
    final name = '${LibraryPaths.sanitizeSegment(_comic.title)}'
        '/${path.split(Platform.pathSeparator).last}';
    try {
      final result = await ExportService.exportChapter(path: path, relativeName: name);
      if (!mounted) return;
      if (result.isEmpty) {
        _toast('导出失败');
        return;
      }
      _toast(Platform.isAndroid ? '已导出到系统「下载」目录' : '已导出到 $result');
      if (!Platform.isAndroid && !Platform.isIOS) {
        await ExportService.revealInExplorer(result);
      }
    } on PlatformException catch (error) {
      if (mounted) _toast('导出失败：${error.message ?? error.code}');
    } on FileSystemException catch (error) {
      if (mounted) _toast('导出失败：${error.message}');
    }
  }

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = context.watch<Library>().progressOf(_comic.id);
    final downloads = context.watch<DownloadManager>();
    final settings = context.watch<Settings>();
    final descending = settings.chapterDescending;
    final episodes = _ordered(descending);
    final resume = _resumeEpisode(progress);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  PicaImage(url: _comic.thumb, cacheWidth: 900),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_comic.title, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text(
                    [
                      _comic.author.isEmpty ? '佚名' : _comic.author,
                      if (_comic.finished) '已完结',
                      '${_comic.epsCount} 话',
                      if (_comic.totalViews > 0) '${_comic.totalViews} 次观看',
                    ].join(' · '),
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                  if (_comic.categories.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        for (final category in _comic.categories.take(6))
                          Chip(
                            label: Text(category, style: const TextStyle(fontSize: 12)),
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                      ],
                    ),
                  ],
                  if (_comic.description.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(_comic.description, style: theme.textTheme.bodyMedium),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          if (_error != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ErrorRetry(message: _error!, onRetry: _load),
              ),
            )
          else if (_loading)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),
            )
          else ...[
            if (_episodes.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            final target = resume ?? _firstEpisode;
                            if (target != null) _open(target);
                          },
                          icon: const Icon(Icons.menu_book),
                          label: Text(
                            progress == null
                                ? '开始阅读'
                                : '继续阅读 · 第 ${progress.order} 话',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () => _downloadAll(downloads),
                        icon: const Icon(Icons.download_for_offline_outlined),
                        label: const Text('全部下载'),
                      ),
                    ],
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '章节 (${_episodeTotal == 0 ? _episodes.length : _episodeTotal})',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          context.read<Settings>().setChapterDescending(!descending),
                      icon: const Icon(Icons.swap_vert, size: 18),
                      label: Text(descending ? '最新在前' : '从第 1 话开始'),
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        foregroundColor: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 260,
                  mainAxisExtent: 46,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: episodes.length,
                  (context, index) {
                    final episode = episodes[index];
                    final current = progress?.order == episode.order;
                    return Material(
                      color: current
                          ? theme.colorScheme.primaryContainer
                          : theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => _open(episode),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  episode.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                              if (current) const Icon(Icons.play_arrow, size: 16),
                              _ChapterAction(
                                chapter: downloads.chapterOf(_comic.id, episode.order),
                                onDownload: () => _download(episode),
                                onPause: () => downloads.pauseChapter(
                                  downloads.chapterOf(_comic.id, episode.order)!,
                                ),
                                onResume: () => downloads.resumeChapter(
                                  downloads.chapterOf(_comic.id, episode.order)!,
                                ),
                                onRetry: () => downloads.retry(
                                  downloads.chapterOf(_comic.id, episode.order)!,
                                ),
                                onMenu: () => _openDownloadedMenu(episode),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (_episodes.length < _episodeTotal)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: _loadingMore
                        ? const CircularProgressIndicator()
                        : TextButton(
                            onPressed: _loadMoreEpisodes,
                            child: const Text('加载更多章节'),
                          ),
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ],
      ),
    );
  }
}

/// Download state of one chapter, sized to sit inside a 46 px grid cell.
class _ChapterAction extends StatelessWidget {
  const _ChapterAction({
    required this.chapter,
    required this.onDownload,
    required this.onPause,
    required this.onResume,
    required this.onRetry,
    required this.onMenu,
  });

  final ChapterDownload? chapter;
  final VoidCallback onDownload;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onRetry;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    final chapter = this.chapter;
    if (chapter == null) {
      return _button(
        icon: const Icon(Icons.download_outlined),
        tooltip: '下载这一话',
        onPressed: onDownload,
      );
    }
    return switch (chapter.state) {
      ChapterState.done => _button(
          icon: Icon(Icons.offline_pin, color: Theme.of(context).colorScheme.primary),
          tooltip: '已下载',
          onPressed: onMenu,
        ),
      ChapterState.failed => _button(
          icon: Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error),
          tooltip: chapter.error.isEmpty ? '下载失败' : chapter.error,
          onPressed: onRetry,
        ),
      ChapterState.paused => _button(
          icon: const Icon(Icons.play_circle_outline),
          tooltip: '继续下载',
          onPressed: onResume,
        ),
      ChapterState.queued => _button(
          icon: const Icon(Icons.schedule),
          tooltip: '排队中',
          onPressed: onPause,
        ),
      ChapterState.running => _button(
          icon: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              value: chapter.totalPages > 0 ? chapter.progress : null,
              strokeWidth: 2,
            ),
          ),
          tooltip: '下载中，点击暂停',
          onPressed: onPause,
        ),
    };
  }

  Widget _button({
    required Widget icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: icon,
      iconSize: 18,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints.tightFor(width: 32, height: 32),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
