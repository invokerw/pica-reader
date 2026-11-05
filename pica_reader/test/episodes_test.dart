import 'package:flutter_test/flutter_test.dart';
import 'package:pica_reader/src/api/api_client.dart';
import 'package:pica_reader/src/api/episodes.dart';
import 'package:pica_reader/src/api/models.dart';

/// Serves prepared pages and records which ones were asked for.
class _FakeApi extends ApiClient {
  _FakeApi(this.pages);

  final Map<int, Paged<Episode>> pages;
  final List<int> requested = [];

  @override
  Future<Paged<Episode>> episodes(String comicId, {int page = 1}) async {
    requested.add(page);
    return pages[page] ?? Paged(docs: const [], page: page);
  }
}

Episode _episode(int order, {String? title}) =>
    Episode(id: 'ep-$order', title: title ?? '第 $order 话', order: order);

Paged<Episode> _page(List<Episode> docs, {required int total, int? pages}) =>
    Paged(docs: docs, total: total, page: 1, pages: pages ?? 0);

void main() {
  group('fetchAllEpisodes', () {
    test('walks every page and returns the chapters oldest first', () async {
      final api = _FakeApi({
        1: _page([_episode(40), _episode(39), _episode(38)], total: 5, pages: 2),
        2: _page([_episode(2), _episode(1)], total: 5, pages: 2),
      });

      final chapters = await fetchAllEpisodes(api, 'comic');

      expect([for (final c in chapters) c.order], [1, 2, 38, 39, 40]);
      expect(api.requested, [1, 2]);
    });

    test('stops when the API repeats a page instead of trusting the total',
        () async {
      final api = _FakeApi({
        1: _page([_episode(3), _episode(2)], total: 99),
        2: _page([_episode(3), _episode(2)], total: 99),
      });

      final chapters = await fetchAllEpisodes(api, 'comic');

      expect([for (final c in chapters) c.order], [2, 3]);
      // The repeated second page answers nothing, so no third request follows.
      expect(api.requested, [1, 2]);
    });

    test('reports partial lists so the picker can fill in as pages arrive',
        () async {
      final api = _FakeApi({
        1: _page([_episode(3), _episode(2)], total: 3, pages: 2),
        2: _page([_episode(1)], total: 3, pages: 2),
      });
      final seen = <List<int>>[];

      await fetchAllEpisodes(
        api,
        'comic',
        onProgress: (chapters) =>
            seen.add([for (final c in chapters) c.order]),
      );

      expect(seen, [
        [2, 3],
        [1, 2, 3],
      ]);
    });

    test('a single page with no total is enough', () async {
      final api = _FakeApi({1: _page([_episode(1)], total: 0)});

      final chapters = await fetchAllEpisodes(api, 'comic');

      expect(chapters, hasLength(1));
      expect(api.requested, [1]);
    });
  });

  group('mergeEpisodes', () {
    test('keeps downloaded chapters the API no longer lists', () {
      final merged = mergeEpisodes(
        known: [_episode(2), _episode(3)],
        downloaded: [_episode(1, title: '离线'), _episode(2, title: '旧标题')],
      );

      expect([for (final c in merged) c.order], [1, 2, 3]);
      expect(merged[0].title, '离线');
      // The API list is the truth for chapters it still has.
      expect(merged[1].title, '第 2 话');
    });

    test('adds the chapter being read when no list knows it', () {
      final merged = mergeEpisodes(
        known: [_episode(1)],
        current: _episode(9, title: '第 9 话'),
      );

      expect([for (final c in merged) c.order], [1, 9]);
    });

    test('never returns the same chapter number twice', () {
      final merged = mergeEpisodes(known: [_episode(1), _episode(1), _episode(2)]);

      expect(merged, hasLength(2));
    });
  });

  group('chapter neighbours', () {
    final chapters = [_episode(1), _episode(3), _episode(8)];

    test('picks the closest chapter in each direction', () {
      expect(previousEpisode(chapters, 3)?.order, 1);
      expect(nextEpisode(chapters, 3)?.order, 8);
    });

    test('returns null at both ends', () {
      expect(previousEpisode(chapters, 1), isNull);
      expect(nextEpisode(chapters, 8), isNull);
    });

    test('skips numbers missing from the list', () {
      expect(previousEpisode(chapters, 8)?.order, 3);
      expect(nextEpisode(chapters, 1)?.order, 3);
      expect(previousEpisode(const [], 1), isNull);
    });
  });
}
