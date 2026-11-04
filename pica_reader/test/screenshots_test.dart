import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pica_reader/src/api/api_client.dart';
import 'package:pica_reader/src/api/models.dart';
import 'package:pica_reader/src/state/downloads.dart';
import 'package:pica_reader/src/state/library.dart';
import 'package:pica_reader/src/state/settings.dart';
import 'package:pica_reader/src/storage/comic_archive.dart';
import 'package:pica_reader/src/storage/comic_info.dart';
import 'package:pica_reader/src/theme/app_themes.dart';
import 'package:pica_reader/src/theme/theme_builder.dart';
import 'package:pica_reader/src/ui/comic_page.dart';
import 'package:pica_reader/src/ui/reader_page.dart';
import 'package:provider/provider.dart';

/// Renders the real screens at phone size and writes them to
/// `pica_reader/build/screenshots` so a human can eyeball the layout.
///
/// The screenshots are drawn off-screen: the system bars do not exist here, so
/// what they prove is the layout (artwork reaching every edge, the chrome
/// padding around the notch, the chapter order), not the immersive mode flag.

const String _fontFamily = 'ShotFont';

/// Typical Android phone in logical pixels.
const Size _phone = Size(411, 914);

final List<String> _shotFiles = [];

Future<void> _register(String family, String path) async {
  final bytes = await File(path).readAsBytes();
  final loader = FontLoader(family)
    ..addFont(Future.value(ByteData.sublistView(bytes)));
  await loader.load();
}

/// The test binding ships with a glyph-less default font and no icon font, so
/// without this every Chinese character and every Icon renders as a box.
Future<void> _loadFonts() async {
  final cjk = <String>[];
  for (final path in const [
    r'C:\Windows\Fonts\simhei.ttf',
    r'C:\Windows\Fonts\Deng.ttf',
  ]) {
    if (File(path).existsSync()) {
      cjk.add(path);
      break;
    }
  }
  for (final path in cjk) {
    await _register(_fontFamily, path);
  }

  for (final path in _iconFontCandidates()) {
    if (!File(path).existsSync()) continue;
    await _register('MaterialIcons', path);
    break;
  }
}

List<String> _iconFontCandidates() {
  const relative = r'bin\cache\artifacts\material_fonts\materialicons-regular.otf';
  final root = Platform.environment['FLUTTER_ROOT'];
  return [
    if (root != null && root.isNotEmpty) '$root\\$relative',
    '..\\.tools\\flutter\\$relative',
    '.tools\\flutter\\$relative',
  ];
}

void _label(Canvas canvas, String text, Offset at, double size, Color color) {
  final paragraph = (ui.ParagraphBuilder(ui.ParagraphStyle(
    fontFamily: _fontFamily,
    fontSize: size,
  ))
        ..pushStyle(ui.TextStyle(
          color: color,
          fontFamily: _fontFamily,
          fontSize: size,
        ))
        ..addText(text))
      .build()
    ..layout(const ui.ParagraphConstraints(width: 600));
  canvas.drawParagraph(paragraph, at);
}

/// A fake manga page: three bordered panels and a page number, so page seams
/// are obvious at a glance.
Future<Uint8List> _pageArt(int page, double ratio) async {
  const width = 720;
  final height = (width * ratio).round();
  final size = Size(width.toDouble(), height.toDouble());
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, Offset.zero & size);
  canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFFFBF8F1));

  const margin = 24.0;
  const tints = [Color(0xFFD8E4F2), Color(0xFFF3E0D8), Color(0xFFDFF0E2)];
  var top = margin;
  var panel = 0;
  for (final share in const [0.32, 0.30, 0.30]) {
    final rect = Rect.fromLTWH(
        margin, top, size.width - margin * 2, size.height * share);
    final rounded = RRect.fromRectAndRadius(rect, const Radius.circular(6));
    canvas.drawRRect(rounded, Paint()..color = tints[panel % tints.length]);
    canvas.drawRRect(
      rounded,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..color = const Color(0xFF232323),
    );
    final bubble = Rect.fromLTWH(
        rect.left + 26, rect.top + 22, rect.width * 0.46, rect.height * 0.28);
    final bubbleShape =
        RRect.fromRectAndRadius(bubble, const Radius.circular(18));
    canvas.drawRRect(bubbleShape, Paint()..color = Colors.white);
    canvas.drawRRect(
      bubbleShape,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = const Color(0xFF232323),
    );
    top += size.height * share + 14;
    panel++;
  }

  _label(canvas, '$page', Offset(size.width - 96, size.height - 84), 52,
      const Color(0xFF9A9A9A));
  final picture = recorder.endRecording();
  final image = await picture.toImage(width, height);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  picture.dispose();
  return data!.buffer.asUint8List();
}

class _ShotSettings extends Settings {
  _ShotSettings({this.mode = ReaderMode.continuous});

  final ReaderMode mode;
  bool _descending = true;

  @override
  ReaderMode get readerMode => mode;

  @override
  bool get chapterDescending => _descending;

  @override
  void setChapterDescending(bool value) {
    if (value == _descending) return;
    _descending = value;
    notifyListeners();
  }
}

/// Reading progress is not part of what these shots audit, and a real library
/// would write into the user's profile directory.
class _ShotLibrary extends Library {
  @override
  void record({
    required String comicId,
    required String comicTitle,
    required String thumb,
    required int order,
    required int page,
    required int totalPages,
  }) {}
}

class _ShotDownloads extends DownloadManager {
  _ShotDownloads(this.chapterFile)
      : super(
          resolvePages: (_, _) async => const [],
          root: () async => '',
        );

  final String? chapterFile;

  @override
  String? localPathOf(String comicId, int order) => chapterFile;
}

class _ShotApi extends ApiClient {
  _ShotApi({required Comic comic, required List<Episode> episodes})
      : _comicDetail = comic,
        _episodeList = episodes;

  final Comic _comicDetail;
  final List<Episode> _episodeList;

  @override
  Future<Comic> comic(String id) async => _comicDetail;

  @override
  Future<Paged<Episode>> episodes(String comicId, {int page = 1}) async =>
      Paged<Episode>(docs: _episodeList, total: _episodeList.length, page: 1);
}

ThemeData _theme(Brightness brightness) {
  final base = buildAppTheme(appThemeById(kDefaultThemeId), brightness);
  // A raw TextStyle with no family (the chip and filled-button themes have
  // one) falls back to the test binding's glyph-less font, so it has to be
  // told about the loaded face explicitly.
  final chipLabel = base.chipTheme.labelStyle;
  final chipSelectedLabel = base.chipTheme.secondaryLabelStyle;
  final buttonText = base.filledButtonTheme.style?.textStyle;
  return base.copyWith(
    textTheme: base.textTheme.apply(fontFamily: _fontFamily),
    primaryTextTheme: base.primaryTextTheme.apply(fontFamily: _fontFamily),
    chipTheme: base.chipTheme.copyWith(
      labelStyle: chipLabel?.copyWith(fontFamily: _fontFamily),
      secondaryLabelStyle: chipSelectedLabel?.copyWith(fontFamily: _fontFamily),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: base.filledButtonTheme.style?.copyWith(
        textStyle: WidgetStatePropertyAll<TextStyle>(
          (buttonText?.resolve(const <WidgetState>{}) ?? const TextStyle())
              .copyWith(fontFamily: _fontFamily),
        ),
      ),
    ),
  );
}

Widget _app({
  required GlobalKey key,
  required Widget home,
  required ApiClient api,
  required Settings settings,
  required DownloadManager downloads,
}) {
  return RepaintBoundary(
    key: key,
    child: MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: api),
        ChangeNotifierProvider<Settings>.value(value: settings),
        ChangeNotifierProvider<Library>(create: (_) => _ShotLibrary()),
        ChangeNotifierProvider<DownloadManager>.value(value: downloads),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _theme(Brightness.light),
        home: home,
      ),
    ),
  );
}

void _usePhone(WidgetTester tester) {
  tester.view.physicalSize = _phone * 2;
  tester.view.devicePixelRatio = 2;
  // A status bar and a gesture bar, as an edge-to-edge phone reports them.
  tester.view.padding = const FakeViewPadding(top: 48, bottom: 96);
  tester.view.viewPadding = const FakeViewPadding(top: 48, bottom: 96);
  addTearDown(tester.view.reset);
}

/// Images decode on the engine's thread, so the fake clock has to give way to
/// real time between pumps.
Future<void> _settle(WidgetTester tester) async {
  for (var round = 0; round < 10; round++) {
    await tester
        .runAsync(() => Future<void>.delayed(const Duration(milliseconds: 40)));
    await tester.pump(const Duration(milliseconds: 40));
  }
}

Future<void> _capture(WidgetTester tester, GlobalKey key, String name) async {
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final file = File('build/screenshots/$name.png');
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 2);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    await file.parent.create(recursive: true);
    await file.writeAsBytes(data!.buffer.asUint8List());
  });
  _shotFiles.add(file.path);
}

const _comic = Comic(
  id: 'comic-1',
  title: '夏日回声',
  author: '海边工作坊',
  description: '暑假回到海边的旧屋，蝉鸣把整个夏天拉得很长。',
  thumb: '',
  totalViews: 128000,
  likesCount: 9600,
  epsCount: 18,
  categories: ['日常', '治愈'],
  updatedAt: '2026-11-01',
);

final _episodes = [
  for (var order = 18; order >= 1; order--)
    Episode(id: 'ep-$order', title: '第 $order 话', order: order),
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory temp;
  late String chapterFile;

  setUpAll(() async {
    await _loadFonts();
    temp = await Directory.systemTemp.createTemp('pica_reader_shots');
    final pages = <String>[];
    for (final ratio in const [1.28, 1.42, 1.30, 2.05, 1.36, 1.44]) {
      final file =
          File('${temp.path}${Platform.pathSeparator}page${pages.length}.png');
      await file.writeAsBytes(await _pageArt(pages.length + 1, ratio));
      pages.add(file.path);
    }
    chapterFile = '${temp.path}${Platform.pathSeparator}第十二话.cbz';
    await ComicArchive.write(
      targetPath: chapterFile,
      pageFiles: pages,
      comicInfoXml:
          const ComicInfo(series: '夏日回声', number: 12, title: '蝉鸣').toXml(),
    );
  });

  tearDownAll(() async {
    if (temp.existsSync()) await temp.delete(recursive: true);
    // ignore: avoid_print
    print('screenshots: ${_shotFiles.join(', ')}');
  });

  testWidgets('reader: the strip runs across page seams', (tester) async {
    _usePhone(tester);
    final key = GlobalKey();
    await tester.pumpWidget(_app(
      key: key,
      api: _ShotApi(comic: _comic, episodes: _episodes),
      settings: _ShotSettings(mode: ReaderMode.continuous),
      downloads: _ShotDownloads(chapterFile),
      home: const ReaderPage(
        comicId: 'comic-1',
        comicTitle: '夏日回声',
        thumb: '',
        episode: Episode(id: 'ep-12', title: '第 12 话 · 蝉鸣', order: 12),
        initialPage: 1,
      ),
    ));
    await _settle(tester);

    // Scroll so a page seam sits in the middle of the screen.
    await tester.drag(find.byType(ListView), const Offset(0, -430));
    await _settle(tester);
    await _capture(tester, key, 'reader_strip_chrome');

    // Tap the artwork: the chrome fades out and only the strip is left.
    await tester.tapAt(const Offset(205, 460));
    await tester.pump(const Duration(milliseconds: 400));
    await _settle(tester);
    await _capture(tester, key, 'reader_strip_immersive');
  });

  testWidgets('detail: newest chapter first, then from chapter one',
      (tester) async {
    _usePhone(tester);
    final key = GlobalKey();
    await tester.pumpWidget(_app(
      key: key,
      api: _ShotApi(comic: _comic, episodes: _episodes),
      settings: _ShotSettings(),
      downloads: _ShotDownloads(null),
      home: const ComicDetailPage(comic: _comic),
    ));
    await _settle(tester);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -320));
    await tester.pumpAndSettle();
    await _capture(tester, key, 'chapters_newest_first');

    await tester.tap(find.text('最新在前'));
    await tester.pumpAndSettle();
    await _capture(tester, key, 'chapters_from_one');
  });
}
