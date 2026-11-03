/// Builds the URL of a chapter image the same way the APK does
/// (`Lvz2;->c` in classes.dex):
///
///   * a trailing `/` on the file server is trimmed;
///   * the server must contain `/static`, otherwise it is appended;
///   * `path` is joined with a single `/`;
///   * `http://` is upgraded and `/static/static/` is collapsed.
///
/// Without the `/static` segment the CDN answers 401 for every image.
String buildImageUrl({required String fileServer, required String path}) {
  var server = fileServer.trim().replaceAll(RegExp(r'/+$'), '');
  if (server.isEmpty) return '';
  if (!server.contains('/static')) {
    server = '$server/static';
  }
  var tail = path.trim();
  while (tail.startsWith('/')) {
    tail = tail.substring(1);
  }
  var url = '$server/$tail';
  if (url.startsWith('http://')) {
    url = 'https://${url.substring('http://'.length)}';
  }
  return url.replaceAll('/static/static/', '/static/');
}
