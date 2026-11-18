import 'dart:convert';

import 'package:http/http.dart' as http;

import 'config.dart';

/// Error dari web service. [fieldErrors] berisi pesan per field dari serializer DRF.
class ApiException implements Exception {
  ApiException(this.statusCode, this.message, [this.fieldErrors = const {}]);

  final int statusCode;
  final String message;
  final Map<String, List<String>> fieldErrors;

  String? field(String name) => fieldErrors[name]?.join('\n');

  @override
  String toString() => message;
}

/// Klien HTTP bersama untuk semua modul.
///
/// Setelah login, token disimpan di sini sehingga setiap request otomatis
/// membawa header `Authorization: Token <key>` yang dibaca Django REST Framework.
/// Modul lain cukup memakai `context.read<AuthService>().api.get('/api/...')`.
class ApiClient {
  ApiClient({http.Client? client, this.baseUrl = apiBaseUrl})
      : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;
  String? token;

  Map<String, String> get _headers => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Token $token',
      };

  Uri _uri(String path, [Map<String, String>? query]) {
    final uri = Uri.parse('$baseUrl$path');
    final params = {...?query}..removeWhere((_, v) => v.isEmpty);
    return params.isEmpty ? uri : uri.replace(queryParameters: params);
  }

  Future<dynamic> get(String path, {Map<String, String>? query}) =>
      _send(() => _client.get(_uri(path, query), headers: _headers));

  Future<dynamic> post(String path, [Map<String, dynamic>? body]) => _send(
      () => _client.post(_uri(path), headers: _headers, body: jsonEncode(body ?? {})));

  Future<dynamic> patch(String path, Map<String, dynamic> body) => _send(
      () => _client.patch(_uri(path), headers: _headers, body: jsonEncode(body)));

  Future<dynamic> _send(Future<http.Response> Function() request) async {
    final http.Response response;
    try {
      response = await request().timeout(const Duration(seconds: 20));
    } catch (_) {
      throw ApiException(0, 'Tidak dapat terhubung ke server. Periksa koneksi internet.');
    }
    final dynamic data = _decode(response);
    if (response.statusCode >= 200 && response.statusCode < 300) return data;
    throw _error(response.statusCode, data);
  }

  dynamic _decode(http.Response response) {
    if (response.body.isEmpty) return null;
    try {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      return null; // mis. halaman error HTML dari server
    }
  }

  ApiException _error(int status, dynamic data) {
    final fields = <String, List<String>>{};
    String? message;
    if (data is Map) {
      data.forEach((key, value) {
        if (key == 'detail' || key == 'message') {
          message = value.toString();
        } else if (value is List) {
          fields[key.toString()] = value.map((e) => e.toString()).toList();
        } else if (value is String) {
          fields[key.toString()] = [value];
        }
      });
    }
    message ??= fields['non_field_errors']?.join('\n') ??
        switch (status) {
          400 => 'Periksa kembali data yang kamu isi.',
          401 || 403 => 'Sesi berakhir. Silakan login kembali.',
          404 => 'Data tidak ditemukan.',
          429 => 'Terlalu banyak percobaan. Coba lagi sebentar lagi.',
          _ => 'Terjadi kesalahan pada server ($status).',
        };
    return ApiException(status, message!, fields);
  }
}
