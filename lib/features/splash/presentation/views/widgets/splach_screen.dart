import 'dart:async';
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
  Timer? _refreshTimer;

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
    final refreshTokenExpirationStr = await TokenStorage.getRefreshTokenExpiration();

    if (accessToken != null && refreshTokenExpirationStr != null) {
      final refreshTokenExpiration = DateTime.tryParse(refreshTokenExpirationStr);
      if (refreshTokenExpiration == null || DateTime.now().isAfter(refreshTokenExpiration)) {
        print("Refresh token expired or invalid. Clearing tokens and redirecting to onboarding.");
        await TokenStorage.clearTokens();
        context.go(AppRouter.kOnboarding);
        return;
      }

      await TokenRefresher.checkAndRefreshToken(); // Check expiration before refreshing

      final newAccessToken = await TokenStorage.getAccessToken();
      if (newAccessToken != null) {
        final roles = TokenDecoder.getRoles(newAccessToken);
        _startPeriodicTokenRefresh();

        if (roles.isNotEmpty) { // Ensure roles are decoded successfully
          if (roles.contains('ADMIN')) {
            print("User is ADMIN, redirecting to admin dashboard.");
            context.go('/adminDashboard');
          } else {
            print("User has valid token but is not ADMIN, redirecting to home.");
            context.go(AppRouter.KHome);
          }
        } else {
          print("No valid roles found in token. Redirecting to onboarding.");
          context.go(AppRouter.kOnboarding);
        }
      } else {
        print("No valid access token after refresh attempt. Redirecting to onboarding.");
        context.go(AppRouter.kOnboarding);
      }
    } else {
      print("No access token or refresh token expiration found. Redirecting to onboarding.");
      context.go(AppRouter.kOnboarding);
    }
  }

  void _startPeriodicTokenRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (_) async {
      print("Periodic token refresh triggered.");
      await TokenRefresher.checkAndRefreshToken();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
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