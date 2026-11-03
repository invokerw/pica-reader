import 'package:flutter_test/flutter_test.dart';

import 'package:pica_reader/src/api/image_url.dart';
import 'package:pica_reader/src/api/models.dart';
import 'package:pica_reader/src/api/signer.dart';

void main() {
  group('Signer', () {
    test('normalizeAccount strips every @', () {
      expect(Signer.normalizeAccount('982697421@qq.com'), '982697421qq.com');
      expect(Signer.normalizeAccount('a@b@c'), 'abc');
      expect(Signer.normalizeAccount(''), '');
    });

    // Vector produced independently by analysis/pica_signature_offline.py,
    // which reads the key and secret straight out of the APK's DEX.
    test('matches the offline Python vector', () {
      final signature = Signer.sign(
        path: '/auth/sign-in',
        query: null,
        time: 1700000000,
        nonce: '0123456789abcdefghijklmnopqrstuv',
        method: 'POST',
      );
      expect(signature, '728cf13eb37668cffb9c307b2ce4d44367318dc3b97e1e11d729f44b3c57b5d8');
    });

    test('empty query behaves like no query', () {
      final without = Signer.sign(
        path: '/auth/sign-in',
        query: null,
        time: 1700000000,
        nonce: '0123456789abcdefghijklmnopqrstuv',
        method: 'POST',
      );
      final empty = Signer.sign(
        path: '/auth/sign-in',
        query: '',
        time: 1700000000,
        nonce: '0123456789abcdefghijklmnopqrstuv',
        method: 'POST',
      );
      expect(empty, without);
    });

    test('query string participates in the signature', () {
      final without = Signer.sign(
        path: '/comics',
        query: null,
        time: 1700000000,
        nonce: '0123456789abcdefghijklmnopqrstuv',
        method: 'GET',
      );
      final withQuery = Signer.sign(
        path: '/comics',
        query: 'page=1&s=dd',
        time: 1700000000,
        nonce: '0123456789abcdefghijklmnopqrstuv',
        method: 'GET',
      );
      expect(withQuery, hasLength(64));
      expect(withQuery, isNot(without));
    });
  });

  group('Comic parsing', () {
    // `/comics` and `/comics/{id}` send the cover as {fileServer, path}; the
    // leaderboard/favourites send a plain string. Both must reach the UI.
    test('thumb object becomes a /static image URL', () {
      final comic = Comic.fromJson({
        '_id': 'abc',
        'title': 'T',
        'thumb': {
          'fileServer': 'https://storage1.picacomic.com',
          'path': 'tobeimg/xyz.jpg',
          'originalName': 'xyz.jpg',
        },
      });
      expect(comic.thumb, 'https://storage1.picacomic.com/static/tobeimg/xyz.jpg');
    });

    test('thumb string is kept as is', () {
      final comic = Comic.fromJson({
        '_id': 'abc',
        'title': 'T',
        'thumb': 'https://storage1.picacomic.com/static/tobeimg/xyz.jpg',
      });
      expect(comic.thumb, 'https://storage1.picacomic.com/static/tobeimg/xyz.jpg');
    });

    test('missing thumb stays empty instead of throwing', () {
      final comic = Comic.fromJson({'_id': 'abc', 'title': 'T'});
      expect(comic.thumb, isEmpty);
    });

    test('buildImageUrl collapses a duplicated /static', () {
      expect(
        buildImageUrl(
          fileServer: 'https://storage1.picacomic.com/static/',
          path: '/static/tobeimg/x.jpg',
        ),
        'https://storage1.picacomic.com/static/tobeimg/x.jpg',
      );
    });
  });
}
