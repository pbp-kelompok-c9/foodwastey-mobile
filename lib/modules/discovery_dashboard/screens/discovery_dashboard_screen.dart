import 'package:flutter/material.dart';

class DiscoveryDashboardScreen extends StatelessWidget {
  const DiscoveryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discovery & Dashboard'),
      ),
      body: const Center(
        child: Text(
          'Halaman Discovery & Dashboard',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
