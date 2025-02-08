import 'package:flutter/material.dart';
import 'package:petsica/features/registeration/presentation/views/welcome_back.dart';

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
      navigatetohome();
    });
  }

  navigatetohome() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
        return const WelcomeBack();
      })));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/splash.png', width: double.infinity),
      ),
    );
  }
}
