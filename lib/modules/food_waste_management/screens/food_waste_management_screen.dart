
import 'package:flutter/material.dart';

class FoodWasteManagementScreen extends StatelessWidget {
  const FoodWasteManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Waste Management'),
      ),
      body: const Center(
        child: Text(
          'Modul Food Waste Management',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
