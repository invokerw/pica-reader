import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pica_reader/src/ui/chapter_source.dart';
import 'package:pica_reader/src/ui/widgets/continuous_reader.dart';

/// Pages that fail to decode immediately.
///
/// A real image would need the engine's codec, which does not finish inside a
/// widget test; failing synchronously keeps the strip's placeholder path
/// deterministic while still exercising the layout maths.
class _NoImage extends ImageProvider<_NoImage> {
  const _NoImage(this.index);

  final int index;

  @override
  Future<_NoImage> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture<_NoImage>(this);

  @override
  ImageStreamCompleter loadImage(_NoImage key, ImageDecoderCallback decode) =>
      OneFrameImageStreamCompleter(
        Future<ImageInfo>.error(StateError('no image for page $index')),
      );

  @override
  bool operator ==(Object other) => other is _NoImage && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

class _FakeChapter implements ChapterSource {
  _FakeChapter(this.length);

  @override
  final int length;

  @override
  bool get isLocal => false;

  @override
  ImageProvider imageAt(int index) => _NoImage(index);

  @override
  void dispose() {}
}

Widget _host(Widget child) => MaterialApp(home: Scaffold(body: child));

/// Logical size the tests lay the strip out at.
const Size _screen = Size(400, 800);

/// Height of one page while no aspect ratio is known (fallback 1.4).
const double _pageHeight = 400 * 1.4;

ScrollController _scrollOf(WidgetTester tester) =>
    tester.widget<ListView>(find.byType(ListView)).controller!;

Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump();
}

void main() {
  Future<ContinuousReaderController> pumpStrip(
    WidgetTester tester, {
    required ChapterSource source,
    int initialPage = 0,
    ValueChanged<int>? onPageChanged,
    VoidCallback? onTap,
  }) async {
    tester.view.physicalSize = _screen;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final controller = ContinuousReaderController();
    await tester.pumpWidget(_host(ContinuousReader(
      source: source,
      controller: controller,
      initialPage: initialPage,
      onPageChanged: onPageChanged ?? (_) {},
      onTap: onTap ?? () {},
    )));
    await _settle(tester);
    return controller;
  }

  testWidgets('the whole chapter is one scroll view instead of a pager', (tester) async {
    final source = _FakeChapter(6);
    var taps = 0;
    await pumpStrip(tester, source: source, onTap: () => taps++);

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(PageView), findsNothing);
    final list = tester.widget<ListView>(find.byType(ListView));
    expect(list.childrenDelegate.estimatedChildCount, source.length);
    expect(tester.getSize(find.byType(ListView)).width, _screen.width);

    // Each page fills the viewport width and keeps its aspect ratio height.
    final page = tester.getSize(find.byType(Image).first);
    expect(page.width, _screen.width);
    expect(page.height, closeTo(_pageHeight, 0.001));

    // A tap on the artwork still reaches the reader chrome.
    await tester.tap(find.byType(ListView));
    expect(taps, 1);
  });

  testWidgets('dragging anywhere in the strip moves the page marker', (tester) async {
    final source = _FakeChapter(20);
    final seen = <int>[];
    await pumpStrip(tester, source: source, onPageChanged: seen.add);

    await tester.drag(find.byType(ListView), const Offset(0, -700));
    await tester.pumpAndSettle();
    expect(seen, isNotEmpty);
    expect(seen.last, greaterThan(0));

    final offset = _scrollOf(tester).offset;
    expect(seen.last, offset ~/ _pageHeight);
  });

  testWidgets('scrolling past a page boundary reports the page at the top edge', (tester) async {
    final source = _FakeChapter(20);
    final seen = <int>[];
    await pumpStrip(tester, source: source, onPageChanged: seen.add);

    final scroll = _scrollOf(tester);
    scroll.jumpTo(_pageHeight + 120);
    await _settle(tester);
    expect(seen, [1]);

    scroll.jumpTo(0);
    await _settle(tester);
    expect(seen, [1, 0]);
  });

  testWidgets('the page slider can jump anywhere in the chapter', (tester) async {
    final source = _FakeChapter(20);
    final controller = await pumpStrip(tester, source: source);

    controller.jumpToPage(9);
    await _settle(tester);
    expect(_scrollOf(tester).offset, closeTo(9 * _pageHeight, 1));
  });

  testWidgets('a chapter opened at a later page starts there', (tester) async {
    final source = _FakeChapter(20);
    await pumpStrip(tester, source: source, initialPage: 5);

    expect(_scrollOf(tester).offset, closeTo(5 * _pageHeight, 1));
  });
}
