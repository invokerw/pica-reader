import 'api_client.dart';
import 'image_url.dart';

/// Collects every page URL of one chapter.
///
/// The endpoint is paginated (`40` pages per response), which the reader used to
/// inline; downloads and the reader now share one implementation so both stop
/// at the same place.
///
/// [quality] overrides the `image-quality` header for this request only: the
/// server bakes the resize instruction into the returned URL, so a download can
/// ask for `original` while the reader keeps its lighter setting.
Future<List<String>> chapterImageUrls(
  ApiClient api,
  String comicId,
  int order, {
  String? quality,
}) async {
  final urls = <String>[];
  var page = 1;
  while (true) {
    final paged = await api.chapterPages(comicId, order, page: page, imageQuality: quality);
    for (final item in paged.docs) {
      final url = buildImageUrl(fileServer: item.media.fileServer, path: item.media.path);
      if (url.isNotEmpty) urls.add(url);
    }
    final hasMore = paged.docs.isNotEmpty && (paged.pages == 0 || page < paged.pages);
    if (!hasMore) break;
    page += 1;
  }
  return urls;
}
