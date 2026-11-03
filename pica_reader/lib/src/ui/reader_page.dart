import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/api_config.dart';
import '../api/image_url.dart';
import '../api/models.dart';
import '../state/library.dart';
import '../state/settings.dart';
import 'widgets/comic_card.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({
    super.key,
    required this.comicId,
    required this.comicTitle,
    required this.thumb,
    required this.episode,
    this.initialPage = 0,
  });

  final String comicId;
  final String comicTitle;
  final String thumb;
  final Episode episode;
  final int initialPage;

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final List<String> _urls = [];
  PageController? _controller;
  bool _loading = true;
  String? _error;
  int _index = 0;
  bool _chrome = true;
  late bool _vertical;
  late Library _library;

  @override
  void initState() {
    super.initState();
    _vertical = context.read<Settings>().verticalReader;
    _library = context.read<Library>();
    _index = widget.initialPage;
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _saveProgress();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final api = context.read<ApiClient>();
      final urls = <String>[];
      var page = 1;
      while (true) {
        final paged = await api.chapterPages(widget.comicId, widget.episode.order, page: page);
        for (final item in paged.docs) {
          final url = buildImageUrl(
            fileServer: item.media.fileServer,
            path: item.media.path,
          );
          if (url.isNotEmpty) urls.add(url);
        }
        final hasMore = paged.docs.isNotEmpty && (paged.pages == 0 || page < paged.pages);
        if (!hasMore) break;
        page += 1;
      }
      if (!mounted) return;
      final start = widget.initialPage.clamp(0, urls.isEmpty ? 0 : urls.length - 1);
      setState(() {
        _urls
          ..clear()
          ..addAll(urls);
        _index = start;
        _controller = PageController(initialPage: start);
      });
      _precache(start);
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _precache(int index) {
    for (final offset in [1, 2]) {
      final next = index + offset;
      if (next >= _urls.length) break;
      precacheImage(
        NetworkImage(_urls[next], headers: const {'User-Agent': ApiConfig.userAgent}),
        context,
        onError: (_, _) {},
      );
    }
  }

  void _saveProgress() {
    if (_urls.isEmpty) return;
    _library.record(
      comicId: widget.comicId,
      comicTitle: widget.comicTitle,
      thumb: widget.thumb,
      order: widget.episode.order,
      page: _index,
      totalPages: _urls.length,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _index = index);
    _precache(index);
    _saveProgress();
  }

  void _toggleChrome() => setState(() => _chrome = !_chrome);

  void _toggleDirection() {
    final vertical = !_vertical;
    setState(() => _vertical = vertical);
    context.read<Settings>().setVerticalReader(vertical);
    // Rebuild the gallery with a controller that keeps the current page.
    final controller = PageController(initialPage: _index);
    final previous = _controller;
    setState(() => _controller = controller);
    WidgetsBinding.instance.addPostFrameCallback((_) => previous?.dispose());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffold,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_loading)
            const Center(child: CircularProgressIndicator())
          else if (_error != null)
            ErrorRetry(message: _error!, onRetry: _load)
          else if (_urls.isEmpty)
            const EmptyState(message: '这一话没有图片')
          else
            PhotoViewGallery.builder(
              itemCount: _urls.length,
              pageController: _controller,
              scrollDirection: _vertical ? Axis.vertical : Axis.horizontal,
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              onPageChanged: _onPageChanged,
              builder: (context, index) => PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(
                  _urls[index],
                  headers: const {'User-Agent': ApiConfig.userAgent},
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 3,
                onTapUp: (_, _, _) => _toggleChrome(),
                errorBuilder: (context, error, stack) => const Center(
                  child: Icon(Icons.broken_image_outlined, color: Colors.white54, size: 48),
                ),
              ),
            ),
          if (_chrome) ...[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
                padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.comicTitle} · ${widget.episode.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      tooltip: _vertical ? '横向翻页' : '纵向翻页',
                      onPressed: _toggleDirection,
                      icon: Icon(
                        _vertical ? Icons.swap_horiz : Icons.swap_vert,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
                padding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 8,
                  bottom: MediaQuery.paddingOf(context).bottom + 8,
                ),
                child: Row(
                  children: [
                    Text(
                      '${_index + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    Expanded(
                      child: Slider(
                        value: _index.toDouble(),
                        max: (_urls.length - 1).clamp(1, double.infinity).toDouble(),
                        onChanged: _urls.length < 2
                            ? null
                            : (value) {
                                final target = value.round();
                                setState(() => _index = target);
                                _controller?.jumpToPage(target);
                              },
                      ),
                    ),
                    Text(
                      '${_urls.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
