import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/downloads.dart';
import 'state/library.dart';
import 'state/session.dart';
import 'state/settings.dart';
import 'ui/home_shell.dart';
import 'ui/login_page.dart';

class PicaReaderApp extends StatelessWidget {
  const PicaReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '哔咔阅读器',
      debugShowCheckedModeBanner: false,
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const _Root(),
    );
  }

  ThemeData _theme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFE0537B),
      brightness: brightness,
    );
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: scheme.surface,
      ),
      cardTheme: const CardThemeData(clipBehavior: Clip.antiAlias),
    );
  }
}

class _Root extends StatefulWidget {
  const _Root();

  @override
  State<_Root> createState() => _RootState();
}

class _RootState extends State<_Root> {
  bool _ready = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final settings = context.read<Settings>();
    final library = context.read<Library>();
    final session = context.read<SessionController>();
    final downloads = context.read<DownloadManager>();
    try {
      await Future.wait([
        settings.load(),
        library.load(),
        session.api.init(),
      ]);
      // The manifest lives in the download folder, which settings decide on,
      // so this has to wait for settings.load().
      await downloads.load();
      await session.restore();
    } catch (error) {
      // Storage problems must not leave the app on a spinner forever.
      _error = error;
    }
    if (mounted) setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) {
    // Mirror the persisted image quality into the signing client.
    final quality = context.select<Settings, String>((settings) => settings.imageQuality);
    context.read<SessionController>().api.imageQuality = quality;

    if (!_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final error = _error;
    if (error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.storage_outlined, size: 48),
                const SizedBox(height: 12),
                const Text('本地存储不可用，设置将只保留在内存中。'),
                const SizedBox(height: 8),
                Text('$error', textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    setState(() => _error = null);
                    _bootstrap();
                  },
                  child: const Text('重试'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Consumer<SessionController>(
      builder: (context, session, _) => session.isSignedIn ? const HomeShell() : const LoginPage(),
    );
  }
}
