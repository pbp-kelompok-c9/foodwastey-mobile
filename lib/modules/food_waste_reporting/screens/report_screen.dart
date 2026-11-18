import 'package:flutter/material.dart';
import 'package:foodwastey_mobile/widgets/app_drawer.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});
  static const routeName = '/reporting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laporan')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Baris horizontal untuk menampilkan 3 InfoCard secara sejajar.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Laporan yang anda buat akan muncul di sini."),
              ],
            ),
          ]
        ),
      ),
    );
  }
}
