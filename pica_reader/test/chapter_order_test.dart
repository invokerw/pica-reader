import 'package:flutter_test/flutter_test.dart';
import 'package:pica_reader/src/api/models.dart';
import 'package:pica_reader/src/ui/chapter_order.dart';

Episode _episode(int order) =>
    Episode(id: 'ep-$order', title: '第 $order 话', order: order);

List<int> _orders(List<Episode> episodes) =>
    episodes.map((episode) => episode.order).toList();

void main() {
  test('descending keeps the newest chapter on top', () {
    final episodes = [_episode(3), _episode(1), _episode(2)];
    expect(_orders(orderEpisodes(episodes, descending: true)), [3, 2, 1]);
  });

  test('ascending puts chapter one on top', () {
    final episodes = [_episode(3), _episode(1), _episode(2)];
    expect(_orders(orderEpisodes(episodes, descending: false)), [1, 2, 3]);
  });

  test('a later page of chapters slots into place instead of stacking up', () {
    // "加载更多章节" appends older chapters: 9..7 came from page one, 4..2 from
    // page two. Both orders must still cover every chapter exactly once.
    final loaded = [
      _episode(9),
      _episode(8),
      _episode(7),
      _episode(4),
      _episode(3),
      _episode(2),
    ];
    expect(_orders(orderEpisodes(loaded, descending: false)), [2, 3, 4, 7, 8, 9]);
    expect(_orders(orderEpisodes(loaded, descending: true)), [9, 8, 7, 4, 3, 2]);
  });

  test('sorting does not touch the list the caller passed in', () {
    final loaded = [_episode(2), _episode(5), _episode(1)];
    orderEpisodes(loaded, descending: false);
    expect(_orders(loaded), [2, 5, 1]);
  });

  test('an empty chapter list stays empty', () {
    expect(orderEpisodes(const [], descending: true), isEmpty);
    expect(orderEpisodes(const [], descending: false), isEmpty);
  });
}
