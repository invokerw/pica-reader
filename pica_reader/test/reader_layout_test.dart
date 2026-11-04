import 'package:flutter_test/flutter_test.dart';
import 'package:pica_reader/src/ui/reader_layout.dart';

void main() {
  test('unread pages fall back to the given ratio', () {
    final layout = ChapterLayout(pageCount: 3, width: 400);
    expect(layout.estimateRatio, 1.4);
    expect(layout.heightOf(0), closeTo(560, 0.001));
    expect(layout.totalHeight, closeTo(1680, 0.001));
  });

  test('a decoded page teaches the strip how tall it is', () {
    final layout = ChapterLayout(pageCount: 3, width: 300);
    layout.learn(0, 1.5);
    expect(layout.knows(0), isTrue);
    expect(layout.knows(1), isFalse);
    expect(layout.heightOf(0), closeTo(450, 0.001));
    // The pages not decoded yet borrow the average of the ones that were.
    expect(layout.estimateRatio, closeTo(1.5, 0.001));
    expect(layout.heightOf(1), closeTo(450, 0.001));
  });

  test('the estimate is the average of every page decoded so far', () {
    final layout = ChapterLayout(pageCount: 4, width: 100, fallbackRatio: 2);
    layout.learn(0, 1);
    layout.learn(2, 3);
    expect(layout.estimateRatio, closeTo(2, 0.001));
    expect(layout.ratioOf(3), closeTo(2, 0.001));
    expect(layout.ratioOf(1), closeTo(2, 0.001));
  });

  test('a single bad page cannot wreck the scroll extent', () {
    final layout = ChapterLayout(pageCount: 2, width: 100);
    for (final ratio in [0.0, -1.0, 31.0, double.nan, double.infinity]) {
      layout.learn(0, ratio);
      expect(layout.knows(0), isFalse, reason: 'ratio $ratio');
    }
    expect(layout.heightOf(0), closeTo(140, 0.001));
  });

  test('offsets add up the pages before them', () {
    final layout = ChapterLayout(pageCount: 4, width: 200);
    layout.learn(0, 1);
    layout.learn(1, 2);
    expect(layout.offsetOf(0), 0);
    expect(layout.offsetOf(1), closeTo(200, 0.001));
    expect(layout.offsetOf(2), closeTo(600, 0.001));
    // The last page still uses the estimate (average 1.5).
    expect(layout.offsetOf(3), closeTo(900, 0.001));
    expect(layout.totalHeight, closeTo(1200, 0.001));
  });

  test('offsets are clamped to the chapter, so a jump cannot overshoot', () {
    final layout = ChapterLayout(pageCount: 2, width: 100);
    expect(layout.offsetOf(-5), 0);
    expect(layout.offsetOf(99), closeTo(layout.totalHeight, 0.001));
  });

  test('widening the strip scales every page with it', () {
    final layout = ChapterLayout(pageCount: 2, width: 100);
    layout.learn(0, 2);
    expect(layout.heightOf(0), closeTo(200, 0.001));
    layout.width = 250;
    expect(layout.heightOf(0), closeTo(500, 0.001));
    expect(layout.totalHeight, closeTo(1000, 0.001));
  });
}
