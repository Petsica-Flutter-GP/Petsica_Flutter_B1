import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/core/utils/token_decoder.dart';
import 'package:petsica/services/signup/token_refresher.dart';
import '../../../../../core/utils/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleSplashLogic();
    });
  }

  Future<void> _handleSplashLogic() async {
    await Future.delayed(const Duration(seconds: 2));
    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken != null) {
      final success = await TokenRefresher.refreshToken();

      if (success) {
        final newAccessToken = await TokenStorage.getAccessToken();
        final roles = TokenDecoder.getRoles(newAccessToken!);

        if (roles.contains('ADMIN')) {
          context.go('/adminDashboard');
        } else {
          context.go(AppRouter.kPost);
        }
      } else {
        await TokenStorage.clearTokens();
        context.go(AppRouter.kOnboarding);
      }
    } else {
      context.go(AppRouter.kOnboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
