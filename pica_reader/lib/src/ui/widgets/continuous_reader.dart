import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollCacheExtent;

import '../chapter_source.dart';
import '../reader_layout.dart';

/// Colour behind a page that is still decoding. Close to black, like the
/// reader background, so a half-loaded strip does not flash white.
const Color _kPageBackdrop = Color(0xFF121212);

/// Handle the page slider uses to move a [ContinuousReader].
class ContinuousReaderController {
  _ContinuousReaderState? _state;

  void _attach(_ContinuousReaderState state) => _state = state;

  void _detach(_ContinuousReaderState state) {
    if (identical(_state, state)) _state = null;
  }

  /// Scrolls so the top of page [index] sits at the top of the viewport.
  void jumpToPage(int index) => _state?.jumpToPage(index);
}

/// Vertical, non-paginated reader: every page is stacked under the previous one
/// at the viewport width, so a downward drag slides through the chapter the way
/// a webtoon or a long strip does instead of snapping one page at a time.
///
/// The current page is worked out from the laid-out render boxes, not from a
/// [PageController], which is why the strip can report progress even though the
/// user stops between two pages.
class ContinuousReader extends StatefulWidget {
  const ContinuousReader({
    super.key,
    required this.source,
    required this.controller,
    required this.initialPage,
    required this.onPageChanged,
    required this.onTap,
    this.onNearEnd,
  });

  final ChapterSource source;
  final ContinuousReaderController controller;
  final int initialPage;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onTap;

  /// Called when the reader is scrolled to (or leaves) the bottom of the
  /// chapter. The current page alone cannot tell: with pages shorter than the
  /// screen the top of the viewport still belongs to the second-to-last page
  /// when the bottom of the strip is reached.
  final ValueChanged<bool>? onNearEnd;

  @override
  State<ContinuousReader> createState() => _ContinuousReaderState();
}

class _ContinuousReaderState extends State<ContinuousReader> {
  /// Keys of the pages currently in the widget tree. Used to find which page
  /// covers the top of the viewport, and where to jump when the user drags the
  /// page slider.
  final Map<int, GlobalKey> _pageKeys = {};

  /// Pages whose ImageStream we are waiting on for a size.
  final Set<int> _ratioRequests = {};

  /// Pages whose image failed: asking again on every scroll would just hammer
  /// a broken URL.
  final Set<int> _ratioFailures = {};

  late final ChapterLayout _layout;
  ScrollController? _scroll;
  int _current = 0;
  bool _indexCheckScheduled = false;

  /// Last value handed to [ContinuousReader.onNearEnd]; null until measured.
  bool? _nearEnd;

  @override
  void initState() {
    super.initState();
    _current = widget.initialPage;
    _layout = ChapterLayout(pageCount: widget.source.length);
    widget.controller._attach(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.sizeOf(context).width;
    if (width <= 0 || width == _layout.width) return;
    final firstLayout = _scroll == null;
    _layout.width = width;
    if (firstLayout) {
      _scroll = ScrollController(initialScrollOffset: _layout.offsetOf(_current))
        ..addListener(_scheduleIndexCheck);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        // The start offset is an estimate: pin the requested page to the top
        // once the first pages are laid out.
        _settleAt(_current, attempts: 2);
        _learnAround(_current);
        _reportNearEnd();
      });
    } else {
      // Rotation or window resize: keep the page the reader was on in place.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _settleAt(_current);
      });
    }
  }

  @override
  void dispose() {
    widget.controller._detach(this);
    _scroll?.dispose();
    super.dispose();
  }

  void jumpToPage(int index) {
    final scroll = _scroll;
    if (scroll == null || !scroll.hasClients || _layout.pageCount == 0) return;
    _current = index.clamp(0, _layout.pageCount - 1);
    final target = _layout.offsetOf(_current);
    scroll.jumpTo(target.clamp(0.0, scroll.position.maxScrollExtent));
    _settleAt(_current, attempts: 2);
  }

  void _scheduleIndexCheck() {
    if (_indexCheckScheduled) return;
    _indexCheckScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _indexCheckScheduled = false;
      if (mounted) _syncVisible();
    });
  }

  void _syncVisible() {
    final index = _topVisiblePage();
    if (index != null && index != _current) {
      _current = index;
      widget.onPageChanged(index);
    }
    _reportNearEnd();
    _learnAround(_current);
  }

  /// The strip is "at the end" when less than a quarter of a screen is left to
  /// scroll; the reader shows its end-of-chapter card on that signal.
  void _reportNearEnd() {
    final onNearEnd = widget.onNearEnd;
    final scroll = _scroll;
    if (onNearEnd == null || scroll == null || !scroll.hasClients) return;
    final position = scroll.position;
    final near = position.extentAfter <= position.viewportDimension * 0.25;
    if (near == _nearEnd) return;
    _nearEnd = near;
    onNearEnd(near);
  }

  /// The strip's own render box, used as the reference for "top of screen".
  RenderBox? _viewportBox() {
    final render = context.findRenderObject();
    if (render is RenderBox && render.hasSize) return render;
    return null;
  }

  /// The page whose body covers the top edge of the viewport.
  int? _topVisiblePage() {
    final viewport = _viewportBox();
    if (viewport == null) return null;
    int? above;
    var aboveTop = double.negativeInfinity;
    int? below;
    var belowTop = double.infinity;
    for (final entry in _pageKeys.entries) {
      final render = entry.value.currentContext?.findRenderObject();
      if (render is! RenderBox || !render.hasSize) continue;
      final top = viewport.globalToLocal(render.localToGlobal(Offset.zero)).dy;
      if (top <= 0.5) {
        if (top > aboveTop) {
          aboveTop = top;
          above = entry.key;
        }
      } else if (top < belowTop) {
        belowTop = top;
        below = entry.key;
      }
    }
    return above ?? below;
  }

  /// Index of a laid-out page closest to [index], used to correct a jump whose
  /// estimate overshot.
  int? _nearestBuilt(int index) {
    int? best;
    var distance = 1 << 30;
    for (final entry in _pageKeys.entries) {
      final render = entry.value.currentContext?.findRenderObject();
      if (render is! RenderBox || !render.hasSize) continue;
      final candidate = (entry.key - index).abs();
      if (candidate < distance) {
        distance = candidate;
        best = entry.key;
      }
    }
    return best;
  }

  /// Puts the top of page [index] at the top of the viewport.
  ///
  /// Pages that were never visited only have an estimated height, so a long
  /// jump can land a page or two off; each frame measures again and walks the
  /// remaining estimated distance, so it settles within [attempts].
  void _settleAt(int index, {int attempts = 1}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final page = _pageKeys[index]?.currentContext;
      if (page != null) {
        Scrollable.ensureVisible(page, alignment: 0, duration: Duration.zero);
        return;
      }
      final scroll = _scroll;
      if (scroll == null || !scroll.hasClients || attempts <= 0) return;
      final anchor = _nearestBuilt(index);
      if (anchor == null) return;
      final remaining = _layout.offsetOf(index) - _layout.offsetOf(anchor);
      final destination =
          (scroll.offset + remaining).clamp(0.0, scroll.position.maxScrollExtent);
      scroll.jumpTo(destination);
      _settleAt(index, attempts: attempts - 1);
    });
  }

  void _learnAround(int index) {
    for (final offset in const [0, 1, 2]) {
      _learnRatio(index + offset);
    }
  }

  /// Asks the image cache how tall page [index] really is, so the placeholder
  /// and the final image occupy exactly the same slot in the strip.
  void _learnRatio(int index) {
    if (index < 0 || index >= _layout.pageCount) return;
    if (_layout.knows(index) || _ratioFailures.contains(index)) return;
    if (!_ratioRequests.add(index)) return;
    final stream =
        widget.source.imageAt(index).resolve(createLocalImageConfiguration(context));
    late final ImageStreamListener listener;
    listener = ImageStreamListener(
      (info, _) {
        stream.removeListener(listener);
        _ratioRequests.remove(index);
        if (!mounted) return;
        final image = info.image;
        if (image.width <= 0 || image.height <= 0) return;
        // A learned height changes the average used for pages we have not seen,
        // so opening a chapter in the middle moves everything above the reader.
        // Shift the offset by the same amount to keep the current page put.
        // Not while flinging, though: that would cancel the user's scroll.
        final scroll = _scroll;
        final pin = scroll != null &&
            scroll.hasClients &&
            !scroll.position.isScrollingNotifier.value;
        final before = pin ? _layout.offsetOf(_current) : 0.0;
        _layout.learn(index, image.height / image.width);
        if (pin) {
          final delta = _layout.offsetOf(_current) - before;
          if (delta != 0) {
            scroll.jumpTo(
              (scroll.offset + delta).clamp(0.0, scroll.position.maxScrollExtent),
            );
          }
        }
        setState(() {});
      },
      onError: (error, stack) {
        stream.removeListener(listener);
        _ratioRequests.remove(index);
        _ratioFailures.add(index);
      },
    );
    stream.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    final scroll = _scroll;
    if (scroll == null) return const SizedBox.shrink();
    return NotificationListener<ScrollMetricsNotification>(
      // Learning a height changes the scroll extent without changing the
      // offset, which can change the page at the top edge.
      onNotification: (_) {
        _scheduleIndexCheck();
        return false;
      },
      child: ListView.builder(
        controller: scroll,
        itemCount: _layout.pageCount,
        // Keep roughly one screen of artwork ready on either side, so the next
        // page is already decoded by the time it scrolls in.
        scrollCacheExtent: const ScrollCacheExtent.viewport(1),
        addAutomaticKeepAlives: false,
        itemBuilder: _buildPage,
      ),
    );
  }

  Widget _buildPage(BuildContext context, int index) {
    final key = _pageKeys.putIfAbsent(
      index,
      () => GlobalKey(debugLabel: 'page-${index + 1}'),
    );
    final width = _layout.width;
    final known = _layout.knows(index);

    Widget image = Image(
      image: widget.source.imageAt(index),
      width: width,
      fit: BoxFit.fitWidth,
      alignment: Alignment.topCenter,
      gaplessPlayback: true,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) return child;
        return const ColoredBox(color: _kPageBackdrop);
      },
      errorBuilder: (context, error, stackTrace) => const ColoredBox(
        color: _kPageBackdrop,
        child: Center(
          child: Icon(Icons.broken_image_outlined, color: Colors.white54, size: 48),
        ),
      ),
    );
    // Until the real ratio is known the box may be shorter than the image; clip
    // it so a page cannot paint over the next one for a frame.
    if (!known) image = ClipRect(child: image);

    return GestureDetector(
      key: key,
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: SizedBox(
        width: width,
        height: _layout.heightOf(index),
        child: image,
      ),
    );
  }
}
