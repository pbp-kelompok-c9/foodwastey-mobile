import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api_client.dart';
import '../models/account.dart';

/// State autentikasi aplikasi. Disediakan lewat Provider di main.dart.
///
/// Modul lain dapat memakai:
///   `final auth = context.watch<AuthService>();`
///   auth.isLoggedIn, auth.account?.isEo, auth.api.get('/api/...')
class AuthService extends ChangeNotifier {
  AuthService({ApiClient? api}) : api = api ?? ApiClient();

  static const _tokenKey = 'auth_token';

  final ApiClient api;
  Account? account;
  bool restoring = true;

  bool get isLoggedIn => account != null;

  /// Memulihkan sesi dari token tersimpan saat aplikasi dibuka.
  Future<void> restore() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    if (token != null) {
      api.token = token;
      try {
        final data = await api.get('/api/auth/me/') as Map<String, dynamic>;
        account = Account.fromJson(data['user'] as Map<String, dynamic>);
      } on ApiException catch (e) {
        // Token tidak berlaku lagi: hapus. Gagal koneksi: biarkan, coba lagi nanti.
        if (e.statusCode == 401) await _clear();
      }
    }
    restoring = false;
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    final data = await api.post('/api/auth/login/', {
      'username': username,
      'password': password,
    }) as Map<String, dynamic>;
    api.token = data['token'] as String;
    (await SharedPreferences.getInstance()).setString(_tokenKey, api.token!);
    account = Account.fromJson(data['user'] as Map<String, dynamic>);
    notifyListeners();
  }

  /// Mengembalikan pesan sukses dari server. Pengguna perlu login setelahnya.
  Future<String> register({
    required String username,
    required String email,
    required String password1,
    required String password2,
  }) async {
    final data = await api.post('/api/auth/register/', {
      'username': username,
      'email': email,
      'password1': password1,
      'password2': password2,
    }) as Map<String, dynamic>;
    return data['message'] as String;
  }

  Future<void> logout() async {
    try {
      await api.post('/api/auth/logout/');
    } on ApiException {
      // Token mungkin sudah tidak berlaku; tetap hapus sesi lokal.
    }
    await _clear();
    notifyListeners();
  }

  Future<void> _clear() async {
    api.token = null;
    account = null;
    (await SharedPreferences.getInstance()).remove(_tokenKey);
  }
}
