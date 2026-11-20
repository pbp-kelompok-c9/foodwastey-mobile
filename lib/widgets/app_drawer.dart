import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme.dart';
import '../modules/auth/screens/login_screen.dart';
import '../modules/auth/screens/register_screen.dart';
import '../modules/auth/services/auth_service.dart';
import 'package:foodwastey_mobile/modules/food_waste_reporting/screens/report_screen.dart';
import '../modules/food_waste_management/screens/food_waste_management_screen.dart';


/// Navigasi utama aplikasi. Setiap modul menambahkan ListTile ke bagiannya.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _push(BuildContext context, Widget page) {
    Navigator.of(context)
      ..pop() // tutup drawer
      ..push(MaterialPageRoute(builder: (_) => page));
  }

  Future<void> _logout(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    await context.read<AuthService>().logout();
    messenger.showSnackBar(const SnackBar(content: Text('Berhasil logout.')));
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final account = auth.account;
    return Drawer(
      backgroundColor: AppColors.paper,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.accentDark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('FoodWastey',
                    style: TextStyle(
                        color: AppColors.accentLight,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                Text(
                  account == null
                      ? 'Kurangi makanan terbuang di setiap acara.'
                      : '@${account.username} · ${account.roleLabel}',
                  style: const TextStyle(color: AppColors.accentLightActive),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Beranda'),
            onTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
          ),

          // ---- Modul lain (Event, Reporting, Management, Discovery) tambahkan di sini.
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Laporan'),
            onTap: () => _push(context, const ReportScreen()),
          ),

          ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Food Waste Management'),
            onTap: () => _push(
              context,
              const FoodWasteManagementScreen(),
            ),
          ),

          const Divider(),
          // ---- Modul User & Authentication
          if (auth.isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _logout(context),
            )
          else ...[
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Masuk'),
              onTap: () => _push(context, const LoginScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.person_add_alt),
              title: const Text('Daftar'),
              onTap: () => _push(context, const RegisterScreen()),
            ),
          ],
        ],
      ),
    );
  }
}
