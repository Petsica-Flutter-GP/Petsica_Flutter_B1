
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_router.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back), // أيقونة الرجوع
      onPressed: () {
        if (GoRouter.of(context).canPop()) {
          GoRouter.of(context).pop(); // ✅ يرجع إذا كان هناك صفحة سابقة
        } else {
          context.go(AppRouter
              .kWhoAreYou); // ✅ يعود للصفحة الرئيسية إذا لم يكن هناك صفحات مكدسة
        }
      },
    );
  }
}
