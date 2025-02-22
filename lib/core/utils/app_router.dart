import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:petsica/features/splash/presentation/views/widgets/splach_screen.dart';
import 'package:petsica/features/onboarding/presentation/views/onboarding.dart';
import 'package:petsica/features/who/presentation/views/who.dart';
import 'package:petsica/features/registeration/presentation/views/welcome_back.dart';

abstract class AppRouter {
  static const kOnboarding = '/onboarding';
  static const kWhoAreYou = '/whoAreYou';
  static const kWelcomeBack = '/welcomeBack';

  static final router = GoRouter(
    initialLocation: '/', // البداية من SplashScreen
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: kOnboarding,
builder: (context, state) => const Onboarding(),
      ),
      GoRoute(
        path: kWhoAreYou,
        builder: (context, state) => const Who(),
      ),
      GoRoute(
        path: kWelcomeBack,
        builder: (context, state) {
          final selectedOption = state.extra as String? ?? 'Unknown';
          return WelcomeBack(selectedOption: selectedOption);
        },
      ),
    ],
  );
}
