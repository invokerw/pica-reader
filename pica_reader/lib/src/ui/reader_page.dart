import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/chapter_pages.dart';
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
  final ContinuousReaderController _strip = ContinuousReaderController();
  ChapterSource? _source;
  PageController? _controller;
  bool _loading = true;
  String? _error;
  int _index = 0;
  bool _chrome = true;
  late ReaderMode _mode;
  late Library _library;

  int get _count => _source?.length ?? 0;

  bool get _offline => _source?.isLocal ?? false;

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
    _index = widget.initialPage;
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
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
    _saveProgress();
    _leaveFullScreen();
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

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final downloads = context.read<DownloadManager>();
    final api = context.read<ApiClient>();
    final previous = _source;
    _source = null;
    previous?.dispose();

    try {
      // A downloaded chapter opens instantly and works without a network.
      ChapterSource? source;
      final localPath = downloads.localPathOf(widget.comicId, widget.episode.order);
      if (localPath != null) {
        try {
          source = LocalChapter.open(localPath);
        } on FormatException {
          // Damaged archive: fall back to streaming instead of showing an error
          // the user cannot act on.
          source = null;
        }
      }
      source ??= RemoteChapter(await chapterImageUrls(
        api,
        widget.comicId,
        widget.episode.order,
      ));
      if (!mounted) {
        source.dispose();
        return;
      }
      final start = widget.initialPage.clamp(0, source.length == 0 ? 0 : source.length - 1);
      setState(() {
        _source = source;
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
      order: widget.episode.order,
      page: _index,
      totalPages: source.length,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _index = index);
    _precache(index);
    _saveProgress();
  }

  void _toggleChrome() => setState(() => _chrome = !_chrome);

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
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('阅读模式：${next.label}'),
        duration: const Duration(milliseconds: 1200),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final source = _source;
    return Scaffold(
      key: _scaffold,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_loading)
            const Center(child: CircularProgressIndicator())
          else if (_error != null)
            ErrorRetry(message: _error!, onRetry: _load)
          else if (source == null || source.length == 0)
            const EmptyState(message: '这一话没有图片')
          else if (_mode == ReaderMode.continuous)
            ContinuousReader(
              source: source,
              controller: _strip,
              initialPage: _index,
              onPageChanged: _onPageChanged,
              onTap: _toggleChrome,
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
                // viewPadding, not padding: with the system bars hidden the
                // padding collapses to zero, but the notch still needs room.
                padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${widget.comicTitle} · ${widget.episode.title}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                            ),
                          ),
                          if (_offline) ...[
                            const SizedBox(width: 8),
                            const Icon(Icons.offline_pin, size: 16, color: Colors.greenAccent),
                          ],
                        ],
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
                  // Same reason as the top bar, plus a little breathing room
                  // so the slider stays clear of the gesture bar.
                  bottom: MediaQuery.viewPaddingOf(context).bottom + 16,
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
                        max: (_count - 1).clamp(1, double.infinity).toDouble(),
                        onChanged: _count < 2
                            ? null
                            : (value) {
                                final target = value.round();
                                setState(() => _index = target);
                                if (_mode == ReaderMode.continuous) {
                                  _strip.jumpToPage(target);
                                } else {
                                  _controller?.jumpToPage(target);
                                }
                              },
                      ),
                    ),
                    Text(
                      '$_count',
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
