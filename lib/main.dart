import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/features/splash/presentation/views/widgets/splach_screen.dart';
import 'package:petsica/features/who/presentation/views/who.dart';

void main() {
  runApp(const Petsica());
}

class Petsica extends StatelessWidget {
  const Petsica({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,

      theme: ThemeData(
        scaffoldBackgroundColor: kAppColor,
      ),

    );
  }
}


