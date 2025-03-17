import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';

class WhereProf extends StatelessWidget {
  const WhereProf({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          text: 'user',
          border: 20,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kUserProfile);
          },
        ),
        const SizedBox(
          height: 30,
        ),
        AppButton(
          text: 'seller',
          border: 20,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kSellerProfile);
          },
        ),
        const SizedBox(
          height: 30,
        ),
        AppButton(
          text: 'sitter',
          border: 20,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kSitterProfile);
          },
        ),
        const SizedBox(
          height: 30,
        ),
        AppButton(
          text: 'clinic',
          border: 20,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kClinicProfile);
          },
        ),
        const SizedBox(
          height: 30,
        ),
        AppButton(
          text: 'admin',
          border: 20,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kAdminProfile);
          },
        ),
      ],
    );
  }
}
