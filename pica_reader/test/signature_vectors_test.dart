import 'package:flutter_test/flutter_test.dart';

import 'package:pica_reader/src/api/signer.dart';

import 'signature_vectors.g.dart';

void main() {
  group('generated signature vectors', () {
    test('the file is not empty', () {
      expect(signatureVectors, isNotEmpty,
          reason: '运行 python analysis/pipeline.py gen 生成向量');
    });

    for (final vector in signatureVectors) {
      final label = '${vector.method} ${vector.path}'
          '${vector.query == null ? '' : '?${vector.query}'}';

      test(label, () {
        final signature = Signer.sign(
          path: vector.path,
          query: vector.query,
          time: vector.time,
          nonce: vector.nonce,
          method: vector.method,
        );
        expect(signature, vector.signature);
      });
    }
  });
}
