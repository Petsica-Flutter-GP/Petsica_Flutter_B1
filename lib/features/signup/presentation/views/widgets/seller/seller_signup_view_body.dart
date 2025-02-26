import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_router.dart';

class SellerSignUpViewBody
 extends StatelessWidget {
  const SellerSignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seller Sign Up"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // أيقونة الرجوع
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop(); // ✅ يرجع إذا كان هناك صفحة سابقة
            } else {
              context.go(AppRouter
                  .kWelcomeBack); // ✅ يعود للصفحة الرئيسية إذا لم يكن هناك صفحات مكدسة
            }
          },
        ),
      ),
      body: const Center(
        child: Text(
          'seller',
          style: TextStyle(color: Colors.black, fontSize: 70),
        ),
      ),
    );
  }
}
