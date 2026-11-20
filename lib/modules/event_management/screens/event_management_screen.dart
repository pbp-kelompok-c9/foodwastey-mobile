import 'package:flutter/material.dart';

class EventManagementScreen extends StatelessWidget {
  const EventManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Management')),
      body: const Center(
        child: Text(
          'Modul Event Management',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
