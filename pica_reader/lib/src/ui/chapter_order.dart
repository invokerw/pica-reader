import '../api/models.dart';

/// Chapters sorted by chapter number, newest first when [descending].
///
/// The API already returns them in descending order, but the list is assembled
/// from several pages and the detail page lets the reader flip it, so sort
/// explicitly instead of trusting the payload order.
List<Episode> orderEpisodes(List<Episode> episodes, {required bool descending}) {
  final sorted = [...episodes]..sort((a, b) => a.order.compareTo(b.order));
  return descending ? sorted.reversed.toList() : sorted;
}
