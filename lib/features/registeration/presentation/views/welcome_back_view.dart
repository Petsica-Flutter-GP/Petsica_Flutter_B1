import 'package:flutter/material.dart';
import 'widgets/welcome_back_view_body.dart';

class WelcomeBackView extends StatelessWidget {
  final String selectedOption; // ✅ استلام الخيار المختار

  const WelcomeBackView({super.key, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeBackViewBody(
          selectedOption: selectedOption), // ✅ تمريره للـ Body
    );
  }
}
