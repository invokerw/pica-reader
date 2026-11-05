import 'api_client.dart';
import 'models.dart';

/// Chapters of [comicId] as one list, oldest chapter first.
///
/// `GET /comics/{id}/eps` is paged (40 chapters a page, newest first). The
/// reader has to step to any neighbouring chapter, so it needs the whole list,
/// not just the page the detail screen happened to load. Pages are requested
/// one after another so a 300-chapter comic costs a few extra round trips
/// rather than a burst; [onProgress] reports every partial list so the chapter
/// picker can fill in while the rest is still on the way.
Future<List<Episode>> fetchAllEpisodes(
  ApiClient api,
  String comicId, {
  void Function(List<Episode> episodes)? onProgress,
}) async {
  final first = await api.episodes(comicId);
  var episodes = sortedEpisodes(first.docs);
  final seen = {for (final episode in episodes) episode.order};
  onProgress?.call(episodes);

  var page = first.page > 0 ? first.page : 1;
  final total = first.total > 0 ? first.total : episodes.length;
  while (episodes.length < total) {
    final next = await api.episodes(comicId, page: page + 1);
    page += 1;
    // Chapters that were already collected (the API repeating a page) or an
    // empty page mean there is nothing left, whatever the total claims.
    final fresh = [
      for (final episode in next.docs)
        if (seen.add(episode.order)) episode,
    ];
    if (fresh.isEmpty) break;
    episodes = sortedEpisodes([...episodes, ...fresh]);
    onProgress?.call(episodes);
    if (next.pages > 0 && page >= next.pages) break;
  }
  return episodes;
}

/// Chapters ordered by chapter number, one entry per number.
List<Episode> sortedEpisodes(Iterable<Episode> episodes) =>
    mergeEpisodes(known: episodes);

/// Gives every chapter number a single entry.
///
/// [known] (what the API said) wins over [downloaded] (what the CBZ manifest
/// says), while [downloaded] keeps chapters that are no longer in the API list.
/// [current] is added when neither list mentions it, so the chapter being read
/// always has a place in the list.
List<Episode> mergeEpisodes({
  Iterable<Episode> known = const [],
  Iterable<Episode> downloaded = const [],
  Episode? current,
}) {
  final byOrder = <int, Episode>{};
  for (final episode in downloaded) {
    byOrder.putIfAbsent(episode.order, () => episode);
  }
  for (final episode in known) {
    byOrder[episode.order] = episode;
  }
  if (current != null) {
    byOrder.putIfAbsent(current.order, () => current);
  }
  final orders = byOrder.keys.toList()..sort();
  return [for (final order in orders) byOrder[order]!];
}

/// The chapter just below [order], or null when [chapters] stops there.
Episode? previousEpisode(List<Episode> chapters, int order) {
  Episode? found;
  for (final episode in chapters) {
    if (episode.order >= order) continue;
    if (found == null || episode.order > found.order) found = episode;
  }
  return found;
}

/// The chapter just above [order], or null when [chapters] stops there.
Episode? nextEpisode(List<Episode> chapters, int order) {
  Episode? found;
  for (final episode in chapters) {
    if (episode.order <= order) continue;
    if (found == null || episode.order < found.order) found = episode;
  }
  return found;
}
