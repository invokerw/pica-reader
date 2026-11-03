// A diagnostic test on purpose: it prints what each live endpoint returned.
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pica_reader/src/api/api_client.dart';
import 'package:pica_reader/src/api/chapter_pages.dart';
import 'package:pica_reader/src/api/image_url.dart';

/// Live end-to-end check of the app's own network layer against the real API.
///
/// It is skipped unless PICA_LIVE_ACCOUNT and PICA_LIVE_PASSWORD are set, so a
/// normal `flutter test` stays offline. Only read endpoints are called; the
/// token lives in memory for the duration of the test.
void main() {
  final account = Platform.environment['PICA_LIVE_ACCOUNT'] ?? '';
  final password = Platform.environment['PICA_LIVE_PASSWORD'] ?? '';
  final skipReason = account.isEmpty || password.isEmpty
      ? 'set PICA_LIVE_ACCOUNT and PICA_LIVE_PASSWORD to run the live check'
      : null;

  test('live: sign in and read comic endpoints', () async {
    final api = ApiClient();
    await api.init();

    final session = await api.signIn(account: account, password: password);
    expect(session.token, isNotEmpty, reason: 'sign-in must return a token');
    api.token = session.token;
    print('sign-in ok, token length ${session.token.length}, '
        'device uuid ${api.deviceUuid}');

    final profile = await api.profile();
    print('profile ok, name "${profile.name}", level ${profile.level}, '
        'email present ${profile.email.isNotEmpty}');

    final first = await api.comics(page: 1);
    expect(first.docs, isNotEmpty);
    print('comics page1: ${first.docs.length} items, total ${first.total}');
    final comic = first.docs.first;

    final second = await api.comics(page: 2);
    print('comics page2: ${second.docs.length} items, page ${second.page}');

    final rank = await api.leaderboard();
    print('leaderboard H24/VC: ${rank.docs.length} items');
    final random = await api.random();
    print('random: ${random.docs.length} items');

    final categories = await api.categories();
    expect(categories, isNotEmpty);
    print('categories: ${categories.length}, first "${categories.first.title}"');
    final filtered = await api.comics(category: categories.first.title);
    print('comics filtered by "${categories.first.title}": ${filtered.docs.length} items');

    final keywords = await api.keywords();
    expect(keywords, isNotEmpty);
    final search = await api.advancedSearch(keyword: keywords.first);
    print('advancedSearch "${keywords.first}": ${search.docs.length} items');
    if (search.docs.isNotEmpty) {
      print('  hit: ${search.docs.first.title}');
    }

    final detail = await api.comic(comic.id);
    print('detail ok: ${detail.title}, eps ${detail.epsCount}, '
        'author ${detail.author}');

    final episodes = await api.episodes(comic.id);
    expect(episodes.docs, isNotEmpty);
    print('episodes: ${episodes.docs.length}, first order ${episodes.docs.first.order}');

    final order = episodes.docs.first.order;
    final pages = await api.chapterPages(comic.id, order);
    expect(pages.docs, isNotEmpty);
    final image = pages.docs.first.media;
    final url = buildImageUrl(fileServer: image.fileServer, path: image.path);
    print('pages: ${pages.docs.length}, image url $url');

    final comments = await api.comments(comic.id);
    print('comments: ${comments.comments.length} loaded, total ${comments.total}');

    // The CDN answers 301 to the resize endpoint; following it proves the signed
    // URL is reachable without the API token.
    final http = HttpClient()..connectionTimeout = const Duration(seconds: 20);
    try {
      final request = await http.getUrl(Uri.parse(url));
      request.headers.set(HttpHeaders.userAgentHeader, 'okhttp/3.8.1');
      final response = await request.close();
      await response.drain<void>();
      print('image HEAD-ish GET: ${response.statusCode} ${response.headers.contentType}');
      expect(response.statusCode, lessThan(400));
    } finally {
      http.close(force: true);
    }

    // Downloads ask for `original`, which the server turns into a different URL
    // than the resized one the reader sees. If this ever stops differing, the
    // archive silently keeps downscaled pages.
    final medium = await chapterImageUrls(api, comic.id, order);
    final original = await chapterImageUrls(api, comic.id, order, quality: 'original');
    expect(original, hasLength(medium.length));
    print('medium page 1:   ${medium.first}');
    print('original page 1: ${original.first}');
    expect(original.first, isNot(medium.first));
  }, skip: skipReason, timeout: const Timeout(Duration(minutes: 5)));
}
