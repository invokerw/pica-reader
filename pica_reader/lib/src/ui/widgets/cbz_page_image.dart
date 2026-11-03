import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import '../../storage/comic_archive.dart';

/// An [ImageProvider] that reads one page out of a local CBZ.
///
/// `Image.file` cannot be used: the page lives inside a zip, not on its own
/// path. Decoding still goes through Flutter's normal pipeline, so the image
/// cache, `photo_view` gestures and precaching all work unchanged.
class CbzPageImage extends ImageProvider<CbzPageImage> {
  const CbzPageImage(this.archive, this.index);

  final ComicArchiveReader archive;
  final int index;

  @override
  Future<CbzPageImage> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture<CbzPageImage>(this);

  @override
  ImageStreamCompleter loadImage(CbzPageImage key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(
      _loadAsync(key, decode),
      informationCollector: () => <DiagnosticsNode>[
        DiagnosticsProperty<String>('Archive', key.archive.path),
        IntProperty('Page', key.index + 1),
      ],
    );
  }

  Future<ImageInfo> _loadAsync(CbzPageImage key, ImageDecoderCallback decode) async {
    final bytes = key.archive.pageBytes(key.index);
    if (bytes.isEmpty) {
      throw StateError('第 ${key.index + 1} 页为空');
    }
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final codec = await decode(buffer);
    final frame = await codec.getNextFrame();
    return ImageInfo(image: frame.image, scale: 1.0);
  }

  @override
  bool operator ==(Object other) =>
      other is CbzPageImage && identical(other.archive, archive) && other.index == index;

  @override
  int get hashCode => Object.hash(identityHashCode(archive), index);

  @override
  String toString() => 'CbzPageImage(${archive.path}#${index + 1})';
}
