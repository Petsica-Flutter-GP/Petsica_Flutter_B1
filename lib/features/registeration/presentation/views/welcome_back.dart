import 'package:flutter/material.dart';
import 'widgets/welcome_back_body.dart';

class WelcomeBack extends StatelessWidget {
  final String selectedOption; // ✅ استلام الخيار المختار

  const WelcomeBack({super.key, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeBackBody(selectedOption: selectedOption), // ✅ تمريره للـ Body
    );
  }
}
