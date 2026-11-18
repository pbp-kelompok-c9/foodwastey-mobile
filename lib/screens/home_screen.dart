import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme.dart';
import '../modules/auth/screens/login_screen.dart';
import '../modules/auth/services/auth_service.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('FoodWastey')),
      drawer: const AppDrawer(),
      body: auth.restoring
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  color: AppColors.accentDark,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auth.isLoggedIn
                              ? 'Halo, ${auth.account!.username}!'
                              : 'Selamat datang di FoodWastey',
                          style: textTheme.headlineSmall?.copyWith(
                              color: AppColors.accentLight, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          auth.isLoggedIn
                              ? 'Kamu masuk sebagai ${auth.account!.roleLabel}.'
                              : 'Masuk untuk melaporkan makanan berlebih dan '
                                  'mengajukan pengambilan makanan.',
                          style: const TextStyle(color: AppColors.accentLightActive),
                        ),
                        if (!auth.isLoggedIn) ...[
                          const SizedBox(height: 16),
                          FilledButton.tonal(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            ),
                            child: const Text('Masuk / Daftar'),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
