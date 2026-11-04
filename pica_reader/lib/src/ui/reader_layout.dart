/// Height bookkeeping for the continuous reader.
///
/// Pages are stacked at the viewport width, so the only unknown is how tall a
/// page is. The real aspect ratio only arrives with the decoded image; until
/// then the average of the pages seen so far is used. A PicACG chapter is
/// normally scanned at one size, so after the first page the placeholders are
/// already the right height and the strip stops moving while the rest loads.
class ChapterLayout {
  ChapterLayout({
    required this.pageCount,
    this.width = 0,
    this.fallbackRatio = 1.4,
  });

  /// Number of pages in the chapter.
  final int pageCount;

  /// Used until at least one page has been decoded.
  final double fallbackRatio;

  /// Width of the strip, and therefore of every page.
  double width;

  /// Height / width of the pages decoded so far, keyed by page index.
  final Map<int, double> _ratios = {};

  bool knows(int index) => _ratios.containsKey(index);

  /// Best guess for a page that has not been decoded yet.
  double get estimateRatio {
    if (_ratios.isEmpty) return fallbackRatio;
    var total = 0.0;
    for (final ratio in _ratios.values) {
      total += ratio;
    }
    return total / _ratios.length;
  }

  double ratioOf(int index) => _ratios[index] ?? estimateRatio;

  /// Records a decoded page. Nonsensical sizes (0, broken headers, extreme
  /// strips) are ignored so one bad page cannot wreck the scroll extent.
  void learn(int index, double ratio) {
    if (!ratio.isFinite || ratio < 0.05 || ratio > 30) return;
    _ratios[index] = ratio;
  }

  double heightOf(int index) => width * ratioOf(index);

  /// Distance from the top of the first page to the top of [index].
  double offsetOf(int index) {
    final end = index.clamp(0, pageCount);
    var offset = 0.0;
    for (var page = 0; page < end; page++) {
      offset += heightOf(page);
    }
    return offset;
  }

  double get totalHeight => offsetOf(pageCount);
}
