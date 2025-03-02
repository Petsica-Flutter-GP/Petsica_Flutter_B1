
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          padding: EdgeInsets.zero, // يجعل الأيقونة بحجمها الطبيعي
          constraints: const BoxConstraints(), // يمنع أي توسيع إضافي
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              size: 20, color: Colors.black),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            } else {
              context.go(AppRouter.kWelcomeBack);
            }
          },
        ),
      ),
    );
  }
}
