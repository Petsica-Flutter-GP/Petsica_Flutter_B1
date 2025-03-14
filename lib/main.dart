import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
void main() {
  // initial 
  runApp(
    DevicePreview(
      enabled: false, // تفعيل معاينة الجهاز
      builder: (context) => const Petsica(),
    ),
  );
}
//حااافلاااااا
class Petsica extends StatelessWidget {
  const Petsica({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
// اخر حاجه 
// اخر حاجه 
// اخر حاجه 
// اخر حاجه 
      // دعم Device Preview
      builder: DevicePreview.appBuilder,
      useInheritedMediaQuery: true,

      theme: ThemeData(
        scaffoldBackgroundColor: kAppColor,
      ),
    );
  }
}
