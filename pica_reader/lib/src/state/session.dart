import 'dart:async';

import 'package:flutter/foundation.dart';

import '../api/api_client.dart';
import '../api/models.dart';
import '../storage/app_paths.dart';

/// Holds the bearer token (PICA calls it `auth_token`) and the signed-in user.
class SessionController extends ChangeNotifier {
  SessionController(this.api);

  final ApiClient api;

  UserProfile? _user;
  String _account = '';
  bool _restoring = true;
  bool _busy = false;

  UserProfile? get user => _user;
  String get account => _account;
  bool get restoring => _restoring;
  bool get busy => _busy;
  bool get isSignedIn => api.token != null;

  Future<void> restore() async {
    final stored = await AppPaths.readJson('session.json');
    final token = asString(stored['token']);
    _account = asString(stored['account']);
    if (token.isNotEmpty) {
      api.token = token;
      final user = stored['user'];
      if (user is Map) _user = UserProfile.fromJson(asMap(user));
    }
    _restoring = false;
    notifyListeners();
    if (token.isNotEmpty) {
      // Verify the stored token; an expired one triggers onUnauthorized.
      try {
        await refreshProfile();
      } on ApiException catch (error) {
        if (error is! AuthException) {
          // Network problems should not sign the user out.
          debugPrint('恢复会话时无法刷新资料: $error');
        }
      }
    }
  }

  Future<void> signIn(String account, String password) async {
    _busy = true;
    notifyListeners();
    try {
      final session = await api.signIn(account: account, password: password);
      api.token = session.token;
      _account = account;
      _user = session.user;
      await AppPaths.writeJson('session.json', {
        'token': session.token,
        'account': account,
        if (session.user != null)
          'user': {'_id': session.user!.id, 'name': session.user!.name},
      });
      notifyListeners();
      // The sign-in payload does not always include the user object.
      if (_user == null) {
        await refreshProfile();
      }
    } finally {
      _busy = false;
      notifyListeners();
    }
  }

  Future<void> refreshProfile() async {
    final profile = await api.profile();
    _user = profile;
    notifyListeners();
    final stored = await AppPaths.readJson('session.json');
    if (asString(stored['token']).isEmpty) return;
    await AppPaths.writeJson('session.json', {
      'token': stored['token'],
      'account': _account,
      'user': {'_id': profile.id, 'name': profile.name},
    });
  }

  Future<void> signOut() async {
    api.token = null;
    _user = null;
    await AppPaths.writeJson('session.json', {});
    notifyListeners();
  }

  /// Called by [ApiClient] when the server rejects the token with 401.
  void handleUnauthorized() {
    api.token = null;
    _user = null;
    unawaited(AppPaths.writeJson('session.json', {}));
    notifyListeners();
  }
}
