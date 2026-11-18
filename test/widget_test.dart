import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodwastey_mobile/core/api_client.dart';
import 'package:foodwastey_mobile/main.dart';
import 'package:foodwastey_mobile/modules/auth/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _session = {
  'token': 'abc123',
  'message': 'Selamat datang, peserta!',
  'user': {'id': 1, 'username': 'peserta', 'email': 'p@example.com', 'is_admin': false, 'is_eo': true},
};

http.Response _json(Object body, [int status = 200]) =>
    http.Response(jsonEncode(body), status, headers: {'content-type': 'application/json'});

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('ApiClient sends token and parses DRF field errors', () async {
    late http.Request captured;
    final api = ApiClient(
      baseUrl: 'http://test',
      client: MockClient((request) async {
        captured = request;
        return _json({'password2': ['Password tidak sama.']}, 400);
      }),
    )..token = 'abc';
    await expectLater(
      api.post('/api/auth/register/', {}),
      throwsA(isA<ApiException>()
          .having((e) => e.field('password2'), 'password2', 'Password tidak sama.')),
    );
    expect(captured.headers['Authorization'], 'Token abc');
  });

  testWidgets('login from drawer updates the app and stores token', (tester) async {
    final api = ApiClient(
      baseUrl: 'http://test',
      client: MockClient((request) async {
        if (request.url.path == '/api/auth/login/') {
          final body = jsonDecode(request.body) as Map;
          return body['password'] == 'benar'
              ? _json(_session)
              : _json({'non_field_errors': ['Username atau password salah.']}, 400);
        }
        return _json({}, 404);
      }),
    );
    await tester.pumpWidget(FoodWasteyApp(authService: AuthService(api: api)));
    await tester.pumpAndSettle();
    expect(find.text('Selamat datang di FoodWastey'), findsOneWidget);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextFormField, 'Username'), 'peserta');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'salah');
    await tester.tap(find.widgetWithText(FilledButton, 'Masuk'));
    await tester.pumpAndSettle();
    expect(find.text('Username atau password salah.'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'benar');
    await tester.tap(find.widgetWithText(FilledButton, 'Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Halo, peserta!'), findsOneWidget);
    expect(find.text('Kamu masuk sebagai Event Organizer.'), findsOneWidget);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('auth_token'), 'abc123');
  });

  testWidgets('register form validates locally before calling API', (tester) async {
    var calls = 0;
    final api = ApiClient(
      baseUrl: 'http://test',
      client: MockClient((_) async {
        calls++;
        return _json({}, 404);
      }),
    );
    await tester.pumpWidget(FoodWasteyApp(authService: AuthService(api: api)));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextFormField, 'Username'), 'nama spasi');
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'bukan-email');
    await tester.tap(find.widgetWithText(FilledButton, 'Daftar'));
    await tester.pumpAndSettle();

    expect(find.text('Gunakan huruf, angka, atau @ . + - _'), findsOneWidget);
    expect(find.text('Masukkan alamat email yang valid.'), findsOneWidget);
    expect(calls, 0);
  });
}
