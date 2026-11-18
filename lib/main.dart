import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme.dart';
import 'modules/auth/services/auth_service.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FoodWasteyApp());
}

class FoodWasteyApp extends StatelessWidget {
  const FoodWasteyApp({super.key, this.authService});

  /// Dapat diganti saat testing.
  final AuthService? authService;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthService>(
      create: (_) => (authService ?? AuthService())..restore(),
      child: MaterialApp(
        title: 'FoodWastey',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}
