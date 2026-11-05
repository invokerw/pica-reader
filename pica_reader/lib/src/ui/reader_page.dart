import 'dart:io';

import 'package:flutter/foundation.dart' show ValueListenable, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/chapter_pages.dart';
import '../api/episodes.dart';
import '../api/models.dart';
import '../state/downloads.dart';
import '../state/library.dart';
import '../state/settings.dart';
import 'chapter_source.dart';
import 'widgets/comic_card.dart';
import 'widgets/continuous_reader.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({
    super.key,
    required this.comicId,
    required this.comicTitle,
    required this.thumb,
    required this.episode,
    this.episodes,
    this.initialPage = 0,
  });

  final String comicId;
  final String comicTitle;
  final String thumb;
  final Episode episode;

  /// Chapters the caller already knows about — the detail page hands over the
  /// list it has loaded. The reader still fetches the complete list itself, so
  /// this only makes the first chapter switch instant.
  final List<Episode>? episodes;
  final int initialPage;

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

/// What the reader knows about the comic's chapter list so far.
class _ChapterIndex {
  const _ChapterIndex({this.chapters = const [], this.loading = true, this.error});

  /// Oldest chapter first.
  final List<Episode> chapters;
  final bool loading;

  /// Why the full list could not be fetched; [chapters] then holds whatever was
  /// known from the caller and from downloaded chapters.
  final String? error;
}

class _ReaderPageState extends State<ReaderPage> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final ContinuousReaderController _strip = ContinuousReaderController();
  final ValueNotifier<_ChapterIndex> _catalog =
      ValueNotifier(const _ChapterIndex());
  ChapterSource? _source;
  PageController? _controller;
  late Episode _episode;
  bool _loading = true;
  String? _error;
  int _index = 0;
  bool _chrome = true;

  /// Continuously scrolled mode reports this itself: at the bottom of the strip
  /// the viewport top can still sit in the second-to-last page.
  bool _nearEnd = false;
  late ReaderMode _mode;
  late Library _library;

  /// Bumped on every chapter load; a late response from an older load is
  /// dropped instead of replacing the chapter the user switched to.
  int _loadToken = 0;

  /// Same idea for the chapter list, which can be retried from the sheet.
  int _catalogToken = 0;

  int get _count => _source?.length ?? 0;

  bool get _offline => _source?.isLocal ?? false;

  Episode? get _previous =>
      previousEpisode(_catalog.value.chapters, _episode.order);

  Episode? get _next => nextEpisode(_catalog.value.chapters, _episode.order);

  /// Icon colour the rest of the app expects in the status bar, captured before
  /// the reader overrides it, so leaving the reader cannot leave white icons on
  /// a light page.
  Brightness _statusIconBrightness = Brightness.light;

  /// Whether the app was already drawing under the system bars when the reader
  /// opened. Restoring the wrong one either leaves the rest of the app under
  /// the status bar or shrinks its window by the height of the bars.
  bool? _wasEdgeToEdge;

  bool get _mobilePlatform =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  void initState() {
    super.initState();
    _mode = context.read<Settings>().readerMode;
    _library = context.read<Library>();
    _episode = widget.episode;
    _index = widget.initialPage;
    // Open with what is already at hand, then let the API fill in the rest.
    _catalog.value = _ChapterIndex(
      chapters: mergeEpisodes(
        known: widget.episodes ?? const [],
        downloaded: _offlineEpisodes(),
        current: _episode,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadChapter(_episode, page: widget.initialPage);
      _loadCatalog();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _statusIconBrightness = Theme.of(context).brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;
    if (_wasEdgeToEdge == null) {
      // Sampled before the bars are hidden: a non-zero inset means the app is
      // edge-to-edge, so that is what has to come back afterwards.
      final insets = MediaQuery.viewPaddingOf(context);
      _wasEdgeToEdge = insets.top > 0 || insets.bottom > 0;
      _enterFullScreen();
    }
  }

  @override
  void dispose() {
    // Stop an in-flight load from touching a state that no longer exists.
    _loadToken++;
    _catalogToken++;
    _saveProgress();
    _leaveFullScreen();
    _catalog.dispose();
    _source?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  /// Reading is a full-screen activity: on a phone the artwork has to reach the
  /// edges, so both system bars go away until the reader is popped.
  void _enterFullScreen() {
    if (!_mobilePlatform) return;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  /// Hands the system bars back in the state the rest of the app expects.
  void _leaveFullScreen() {
    if (!_mobilePlatform) return;
    if (_wasEdgeToEdge ?? false) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: _statusIconBrightness,
      statusBarBrightness:
          _statusIconBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness: _statusIconBrightness,
    ));
  }

  /// Chapters that are on disk, used as the chapter list when the API cannot be
  /// reached and merged into the online list otherwise.
  List<Episode> _offlineEpisodes() {
    final comic = context.read<DownloadManager>().comicOf(widget.comicId);
    if (comic == null) return const [];
    return [
      for (final chapter in comic.sortedChapters)
        if (chapter.isDone)
          Episode(id: chapter.episodeId, title: chapter.title, order: chapter.order),
    ];
  }

  Set<int> _downloadedOrders() {
    final comic = context.read<DownloadManager>().comicOf(widget.comicId);
    if (comic == null) return const <int>{};
    return {
      for (final chapter in comic.sortedChapters)
        if (chapter.isDone) chapter.order,
    };
  }

  /// Loads every chapter of the comic so the reader can step from one to the
  /// next without going back to the detail page.
  Future<void> _loadCatalog() async {
    final token = ++_catalogToken;
    final api = context.read<ApiClient>();

    void publish(List<Episode> chapters, {required bool loading, String? error}) {
      if (!mounted || token != _catalogToken) return;
      _catalog.value = _ChapterIndex(
        chapters: mergeEpisodes(
          known: chapters,
          downloaded: _offlineEpisodes(),
          current: _episode,
        ),
        loading: loading,
        error: error,
      );
      // The toolbar's end-of-chapter card and the arrows read the list too.
      setState(() {});
    }

    publish(_catalog.value.chapters, loading: true);
    try {
      final chapters = await fetchAllEpisodes(
        api,
        widget.comicId,
        onProgress: (partial) => publish(partial, loading: true),
      );
      publish(chapters, loading: false);
    } on ApiException catch (error) {
      publish(_catalog.value.chapters, loading: false, error: error.message);
    } on Exception {
      publish(_catalog.value.chapters, loading: false, error: '章节列表加载失败');
    }
  }

  /// Opens [episode] in place: the reader stays, only the pages change.
  Future<void> _loadChapter(
    Episode episode, {
    int page = 0,
    bool atEnd = false,
  }) async {
    final token = ++_loadToken;
    _saveProgress();

    final previousSource = _source;
    final previousController = _controller;
    final downloads = context.read<DownloadManager>();
    final api = context.read<ApiClient>();

    setState(() {
      _loading = true;
      _error = null;
    });

    final ChapterSource source;
    try {
      source = await _openSource(episode, downloads, api);
    } on ApiException catch (error) {
      if (!mounted || token != _loadToken) return;
      setState(() {
        _loading = false;
        // Only a load with nothing on screen falls back to the error page; a
        // chapter switch that fails keeps the chapter the reader was on.
        if (previousSource == null) _error = error.message;
      });
      if (previousSource != null) _showMessage('打不开这一话：${error.message}');
      return;
    }

    if (!mounted || token != _loadToken) {
      source.dispose();
      return;
    }
    final start = source.length == 0
        ? 0
        : atEnd
            ? source.length - 1
            : page.clamp(0, source.length - 1);
    final controller = PageController(initialPage: start);
    setState(() {
      _episode = episode;
      _source = source;
      _index = start;
      _controller = controller;
      _loading = false;
      _error = null;
      _nearEnd = false;
    });
    _precache(start);
    // History follows the reader across chapters instead of waiting for the
    // next page turn.
    _saveProgress();
    // The gallery that was using them is gone after this frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      previousSource?.dispose();
      previousController?.dispose();
    });
  }

  Future<ChapterSource> _openSource(
    Episode episode,
    DownloadManager downloads,
    ApiClient api,
  ) async {
    // A downloaded chapter opens instantly and works without a network.
    final localPath = downloads.localPathOf(widget.comicId, episode.order);
    ChapterSource? restored;
    if (localPath != null) {
      try {
        restored = LocalChapter.open(localPath);
      } on FormatException {
        // Damaged archive: fall back to streaming instead of showing an error
        // the user cannot act on.
        restored = null;
      }
    }
    if (restored != null) return restored;
    return RemoteChapter(await chapterImageUrls(api, widget.comicId, episode.order));
  }

  void _precache(int index) {
    final source = _source;
    if (source == null) return;
    for (final offset in [1, 2]) {
      final next = index + offset;
      if (next >= source.length) break;
      precacheImage(source.imageAt(next), context, onError: (_, _) {});
    }
  }

  void _saveProgress() {
    final source = _source;
    if (source == null || source.length == 0) return;
    _library.record(
      comicId: widget.comicId,
      comicTitle: widget.comicTitle,
      thumb: widget.thumb,
      order: _episode.order,
      page: _index,
      totalPages: source.length,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _index = index);
    _precache(index);
    _saveProgress();
  }

  void _onNearEnd(bool near) {
    if (near == _nearEnd) return;
    setState(() => _nearEnd = near);
  }

  void _toggleChrome() => setState(() => _chrome = !_chrome);

  void _showMessage(String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1600),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// The mode the toolbar button switches to.
  ReaderMode get _nextMode {
    const modes = ReaderMode.values;
    return modes[(modes.indexOf(_mode) + 1) % modes.length];
  }

  static IconData _iconFor(ReaderMode mode) => switch (mode) {
        ReaderMode.horizontal => Icons.swap_horiz,
        ReaderMode.vertical => Icons.swap_vert,
        ReaderMode.continuous => Icons.view_day,
      };

  void _cycleMode() {
    final next = _nextMode;
    setState(() => _mode = next);
    context.read<Settings>().setReaderMode(next);
    if (next != ReaderMode.continuous) {
      // The gallery needs a controller pinned to the page we are on; while in
      // continuous mode `_index` was kept up to date by the strip.
      final controller = PageController(initialPage: _index);
      final previous = _controller;
      setState(() => _controller = controller);
      WidgetsBinding.instance.addPostFrameCallback((_) => previous?.dispose());
      _precache(_index);
    }
    _showMessage('阅读模式：${next.label}');
  }

  void _seek(double value) {
    final target = value.round();
    setState(() => _index = target);
    if (_mode == ReaderMode.continuous) {
      _strip.jumpToPage(target);
    } else {
      _controller?.jumpToPage(target);
    }
  }

  void _goPrevious() {
    final previous = _previous;
    if (previous != null) {
      // Going back should land on the end of the previous chapter, the way
      // flipping back through a paper volume does.
      _loadChapter(previous, atEnd: true);
      return;
    }
    _reportMissingChapter(forward: false);
  }

  void _goNext() {
    final next = _next;
    if (next != null) {
      _loadChapter(next);
      return;
    }
    _reportMissingChapter(forward: true);
  }

  void _reportMissingChapter({required bool forward}) {
    final catalog = _catalog.value;
    if (catalog.error != null) {
      _showMessage('章节列表加载失败，正在重试…');
      _loadCatalog();
      return;
    }
    if (catalog.loading) {
      _showMessage('章节列表还在加载…');
      return;
    }
    _showMessage(forward ? '已经是最后一话' : '已经是第一话');
  }

  Future<void> _pickChapter() async {
    final chosen = await showModalBottomSheet<Episode>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => _ChapterSheet(
        catalog: _catalog,
        currentOrder: _episode.order,
        descending: context.read<Settings>().chapterDescending,
        downloaded: _downloadedOrders(),
        onRetry: _loadCatalog,
      ),
    );
    if (!mounted || chosen == null) return;
    if (chosen.order == _episode.order && _error == null) return;
    await _loadChapter(chosen);
  }

  void _reload() => _loadChapter(_episode, page: _index);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final source = _source;
    final endCard = _buildChapterEnd();
    return Scaffold(
      key: _scaffold,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_loading)
            const Center(child: CircularProgressIndicator())
          else if (_error != null)
            ErrorRetry(message: _error!, onRetry: _reload)
          else if (source == null || source.length == 0)
            const EmptyState(message: '这一话没有图片')
          else if (_mode == ReaderMode.continuous)
            ContinuousReader(
              // One chapter per state: the strip lays its pages out from the
              // source it was created with, so a new chapter needs a new state.
              key: ValueKey(_episode.order),
              source: source,
              controller: _strip,
              initialPage: _index,
              onPageChanged: _onPageChanged,
              onTap: _toggleChrome,
              onNearEnd: _onNearEnd,
            )
          else
            PhotoViewGallery.builder(
              itemCount: source.length,
              pageController: _controller,
              scrollDirection:
                  _mode == ReaderMode.vertical ? Axis.vertical : Axis.horizontal,
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              onPageChanged: _onPageChanged,
              builder: (context, index) => PhotoViewGalleryPageOptions(
                imageProvider: source.imageAt(index),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 3,
                onTapUp: (_, _, _) => _toggleChrome(),
                errorBuilder: (context, error, stack) => const Center(
                  child: Icon(Icons.broken_image_outlined, color: Colors.white54, size: 48),
                ),
              ),
            ),
          if (_chrome) ...[
            _buildTopBar(theme),
            _buildBottomBar(),
          ],
          ?endCard,
        ],
      ),
    );
  }

  Widget _buildTopBar(ThemeData theme) {
    return Positioned(
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
        // viewPadding, not padding: with the system bars hidden the padding
        // collapses to zero, but the notch still needs room.
        padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            Expanded(
              // The title doubles as the way into the chapter list, so switching
              // chapters never means leaving the reader.
              child: InkWell(
                onTap: _pickChapter,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          '${widget.comicTitle} · ${_episode.title}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                        ),
                      ),
                      if (_offline) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.offline_pin, size: 16, color: Colors.greenAccent),
                      ],
                      const SizedBox(width: 4),
                      const Icon(Icons.expand_more, size: 18, color: Colors.white70),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              tooltip: '切换到${_nextMode.label}',
              onPressed: _cycleMode,
              icon: Icon(_iconFor(_nextMode), color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    final max = (_count - 1).clamp(1, double.infinity).toDouble();
    // While a chapter loads `_index` may still point past the old page count.
    final value = _index.clamp(0, max.toInt()).toDouble();
    return Positioned(
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
          left: 8,
          right: 8,
          top: 8,
          // Same reason as the top bar, plus a little breathing room so the
          // slider stays clear of the gesture bar.
          bottom: MediaQuery.viewPaddingOf(context).bottom + 16,
        ),
        child: Row(
          children: [
            _chapterButton(
              icon: Icons.skip_previous,
              tooltip: '上一话',
              onPressed: _goPrevious,
            ),
            Text(
              '${_index + 1}',
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
            Expanded(
              child: Slider(
                value: value,
                max: max,
                onChanged: _count < 2 ? null : _seek,
              ),
            ),
            Text(
              '$_count',
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
            _chapterButton(
              icon: Icons.skip_next,
              tooltip: '下一话',
              onPressed: _goNext,
            ),
          ],
        ),
      ),
    );
  }

  /// Compact arrow for the toolbar: it changes chapters, not pages.
  Widget _chapterButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
      icon: Icon(icon, color: Colors.white70, size: 22),
    );
  }

  /// Shown once the reader reaches the last page: the chapter is over, and the
  /// next one is one tap away without leaving the reader.
  Widget? _buildChapterEnd() {
    if (_loading ||
        _error != null ||
        _count == 0 ||
        !(_nearEnd || _index >= _count - 1)) {
      return null;
    }
    final catalog = _catalog.value;
    if (catalog.chapters.isEmpty) return null;
    final next = _next;
    // Without a complete list it is not known whether this was the last
    // chapter, so the card stays away instead of claiming an ending.
    if (next == null && (catalog.loading || catalog.error != null)) return null;
    final bottom =
        MediaQuery.viewPaddingOf(context).bottom + (_chrome ? 92 : 24);
    return Positioned(
      left: 16,
      right: 16,
      bottom: bottom,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white24),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 6, next == null ? 16 : 6, 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  next == null ? '本话完 · 已是最后一话' : '本话完',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                if (next != null) ...[
                  const SizedBox(width: 6),
                  TextButton.icon(
                    onPressed: _goNext,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white24,
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: const Icon(Icons.skip_next, size: 18),
                    label: const Text('下一话'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The comic's chapters, with the chapter being read highlighted.
///
/// It follows the catalog notifier so it keeps filling in when it was opened
/// before the API answered; tapping a chapter pops the sheet with that chapter.
class _ChapterSheet extends StatefulWidget {
  const _ChapterSheet({
    required this.catalog,
    required this.currentOrder,
    required this.descending,
    required this.downloaded,
    required this.onRetry,
  });

  final ValueListenable<_ChapterIndex> catalog;
  final int currentOrder;
  final bool descending;
  final Set<int> downloaded;
  final VoidCallback onRetry;

  @override
  State<_ChapterSheet> createState() => _ChapterSheetState();
}

class _ChapterSheetState extends State<_ChapterSheet> {
  static const double _itemExtent = 52;

  final ScrollController _scroll = ScrollController();
  bool _revealed = false;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  List<Episode> _displayed(List<Episode> chapters) =>
      widget.descending ? chapters.reversed.toList(growable: false) : chapters;

  /// Opens the list at the chapter being read instead of at chapter one.
  void _revealCurrent(List<Episode> chapters) {
    if (_revealed || chapters.length < 2) return;
    final index = _displayed(chapters)
        .indexWhere((episode) => episode.order == widget.currentOrder);
    if (index <= 0) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _revealed || !_scroll.hasClients) return;
      _revealed = true;
      _scroll.jumpTo(
        (index * _itemExtent - _itemExtent)
            .clamp(0.0, _scroll.position.maxScrollExtent),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.66,
      child: ValueListenableBuilder<_ChapterIndex>(
        valueListenable: widget.catalog,
        builder: (context, catalog, _) {
          final chapters = _displayed(catalog.chapters);
          _revealCurrent(catalog.chapters);
          return Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text('章节', style: theme.textTheme.titleMedium),
                  const SizedBox(width: 8),
                  if (catalog.chapters.isNotEmpty)
                    Text(
                      '共 ${catalog.chapters.length} 话',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.outline),
                    ),
                  const Spacer(),
                  if (catalog.loading)
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  else
                    const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 4),
              if (catalog.error != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 12, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          catalog.error!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.error),
                        ),
                      ),
                      TextButton(onPressed: widget.onRetry, child: const Text('重试')),
                    ],
                  ),
                ),
              Expanded(
                child: chapters.isEmpty
                    ? Center(
                        child: catalog.loading
                            ? const SizedBox.shrink()
                            : const Text('没有章节'),
                      )
                    : ListView.builder(
                        controller: _scroll,
                        itemExtent: _itemExtent,
                        itemCount: chapters.length,
                        itemBuilder: (context, index) {
                          final episode = chapters[index];
                          final current = episode.order == widget.currentOrder;
                          return ListTile(
                            dense: true,
                            selected: current,
                            leading: SizedBox(
                              width: 20,
                              child: current
                                  ? Icon(
                                      Icons.play_arrow,
                                      size: 20,
                                      color: theme.colorScheme.primary,
                                    )
                                  : null,
                            ),
                            title: Text(
                              episode.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: widget.downloaded.contains(episode.order)
                                ? Icon(
                                    Icons.offline_pin,
                                    size: 18,
                                    color: theme.colorScheme.outline,
                                  )
                                : null,
                            onTap: () => Navigator.of(context).pop(episode),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
