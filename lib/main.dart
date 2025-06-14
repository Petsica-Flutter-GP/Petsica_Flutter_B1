import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const Petsica(),
    ),
  );
}

class Petsica extends StatelessWidget {
  const Petsica({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      builder: DevicePreview.appBuilder,
      useInheritedMediaQuery: true,
      theme: ThemeData(
        scaffoldBackgroundColor: kAppColor,
      ),
    );
  }
}
