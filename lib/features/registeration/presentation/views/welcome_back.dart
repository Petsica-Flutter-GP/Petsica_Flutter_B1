import 'package:flutter/material.dart';

import 'widgets/welcome_back_body.dart';

class WelcomeBack extends StatelessWidget {
  const WelcomeBack({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeBackBody(),
    );
  }
}
