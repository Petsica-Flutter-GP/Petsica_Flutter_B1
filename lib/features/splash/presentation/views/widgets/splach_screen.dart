import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      navigateToOnboarding();
    });
  }

  navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      context.go(AppRouter.kOnboarding); // ✅ الانتقال إلى شاشة الـ Onboarding
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          width: MediaQuery.of(context).size.width * 0.8, // ✅ تقليل العرض
          height: MediaQuery.of(context).size.height * 0.5, // ✅ تقليل الارتفاع
          fit: BoxFit.contain, // ✅ الحفاظ على الأبعاد الأصلية للصورة
        ),
      ),
    );
  }
}
