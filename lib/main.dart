import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/features/splash/presentation/views/widgets/splach_screen.dart';

void main() {
  runApp(const Petsica());
}

class Petsica extends StatelessWidget {
  const Petsica({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ✅ ضبط الثيم الأساسي للتطبيق
      theme: ThemeData(
        scaffoldBackgroundColor: kAppColor, // لون الخلفية الافتراضي لكل الشاشات
      ),

      home: const SplashScreen(),
    );
  }
}



// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("الرئيسية")),
//       body: const Center(
//         child: Text('مرحبًا بك!'),
//       ),
//     );
//   }
// }
