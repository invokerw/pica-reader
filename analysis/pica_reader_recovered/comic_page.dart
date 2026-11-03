import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/models.dart';
import '../state/library.dart';
import 'reader_page.dart';
import 'widgets/comic_card.dart';
import 'widgets/pica_image.dart';

class ComicPage extends StatefulWidget {
  const ComicPage({super.key, required this.comic});

  final Comic comic;

  @override
  State<ComicPage> createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = context.watch<Library>().progressOf(_comic.id);
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
                            final target = resume ?? _episodes.last;
                            _open(target);
                          },
                          icon: const Icon(Icons.menu_book),
                          label: Text(
                            progress == null
                                ? '开始阅读'
                                : '继续阅读 · 第 ${progress.order} 话',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text('章节 (${_episodeTotal == 0 ? _episodes.length : _episodeTotal})',
                    style: theme.textTheme.titleMedium),
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
                  childCount: _episodes.length,
                  (context, index) {
                    final episode = _episodes[index];
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
