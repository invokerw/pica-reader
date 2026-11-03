import 'package:flutter/material.dart';

import '../api/api_config.dart';

/// Network image with the okhttp user agent the API expects and friendly
/// loading/error states. Animated GIFs and long strips both work.
class PicaImage extends StatelessWidget {
  const PicaImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.borderRadius,
  });

  final String url;
  final BoxFit fit;
  final int? cacheWidth;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeholder = ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: const Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );

    Widget child;
    if (url.isEmpty) {
      child = ColoredBox(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Icon(Icons.broken_image_outlined, color: theme.colorScheme.outline),
      );
    } else {
      child = Image.network(
        url,
        fit: fit,
        cacheWidth: cacheWidth,
        headers: const {'User-Agent': ApiConfig.userAgent},
        loadingBuilder: (context, widget, progress) =>
            progress == null ? widget : placeholder,
        errorBuilder: (context, error, stack) => ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest,
          child: Icon(Icons.broken_image_outlined, color: theme.colorScheme.outline),
        ),
      );
    }

    if (borderRadius == null) return child;
    return ClipRRect(borderRadius: borderRadius!, child: child);
  }
}
