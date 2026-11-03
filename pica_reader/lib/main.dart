import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/api/api_client.dart';
import 'src/api/chapter_pages.dart';
import 'src/app.dart';
import 'src/state/downloads.dart';
import 'src/state/library.dart';
import 'src/state/session.dart';
import 'src/state/settings.dart';
import 'src/storage/library_paths.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final api = ApiClient();
  final session = SessionController(api);
  api.onUnauthorized = session.handleUnauthorized;
  final settings = Settings();
  final downloads = DownloadManager(
    // Downloads keep the untouched originals; the reader's lighter quality
    // setting only affects what is streamed on screen.
    resolvePages: (comicId, order) =>
        chapterImageUrls(api, comicId, order, quality: 'original'),
    root: () => LibraryPaths.resolveRoot(settings.downloadRoot),
    pagesPerChapter: () => settings.downloadPages,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: api),
        ChangeNotifierProvider<SessionController>.value(value: session),
        ChangeNotifierProvider<Settings>.value(value: settings),
        ChangeNotifierProvider<Library>(create: (_) => Library()),
        ChangeNotifierProvider<DownloadManager>.value(value: downloads),
      ],
      child: const PicaReaderApp(),
    ),
  );
}
