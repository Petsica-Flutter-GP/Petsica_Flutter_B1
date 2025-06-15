import 'package:flutter/material.dart';
import 'reminder_list.dart';

void main() {
  runApp(const ReminderApp());
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff70161E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff70161E),
        ),
      ),
      home: const ReminderListScreen(),
    );
  }
}