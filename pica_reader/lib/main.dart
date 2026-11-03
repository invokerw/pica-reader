import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/api/api_client.dart';
import 'src/app.dart';
import 'src/state/library.dart';
import 'src/state/session.dart';
import 'src/state/settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final api = ApiClient();
  final session = SessionController(api);
  api.onUnauthorized = session.handleUnauthorized;

  runApp(
    MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: api),
        ChangeNotifierProvider<SessionController>.value(value: session),
        ChangeNotifierProvider<Settings>(create: (_) => Settings()),
        ChangeNotifierProvider<Library>(create: (_) => Library()),
      ],
      child: const PicaReaderApp(),
    ),
  );
}
