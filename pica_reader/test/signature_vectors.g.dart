// GENERATED FILE - DO NOT EDIT.
//
// 由 Python 用同一套常量算出的签名，Dart 侧必须逐个复现。
// Source : analysis/baseline/protocol.json
// Sample : picacg-v2.6.73.apk (sha256 68b1a02d634f791a673bd58935208cde8c896a6ea0912fcbf1b946d9a229c06e)
// Regen  : python analysis/pipeline.py gen


class SignatureVector {
  const SignatureVector({
    required this.path,
    this.query,
    required this.time,
    required this.nonce,
    required this.method,
    required this.signature,
  });

  final String path;
  final String? query;
  final int time;
  final String nonce;
  final String method;
  final String signature;
}

const List<SignatureVector> signatureVectors = [
  SignatureVector(
    path: '/auth/sign-in',
    query: null,
    time: 1700000000,
    nonce: '0123456789abcdefghijklmnopqrstuv',
    method: 'POST',
    signature: '728cf13eb37668cffb9c307b2ce4d44367318dc3b97e1e11d729f44b3c57b5d8',
  ),
  SignatureVector(
    path: '/comics',
    query: 'page=1&s=dd',
    time: 1700000001,
    nonce: 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',
    method: 'GET',
    signature: 'e5e7269cc7c398b4f5de91a10d07a10e6feb4ab9216e6c3ad1c83d5d33a55f2d',
  ),
  SignatureVector(
    path: '/comics',
    query: 'b=2&a=1',
    time: 1700000002,
    nonce: '0123456789abcdefghijklmnopqrstuv',
    method: 'GET',
    signature: '0daaf24f2530661c8b3dc7bb392ac5133cdcefd66bd28ea78c7901ead5ae13aa',
  ),
];
