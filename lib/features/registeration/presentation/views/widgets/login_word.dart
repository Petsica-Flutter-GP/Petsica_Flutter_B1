import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';

class LoginWord extends StatelessWidget {
  const LoginWord(
      {super.key,
      required this.text1,
      required this.text2,
      required this.userType});

  final String text1;
  final String text2;
  final String userType;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: Styles.textStyleCom14,
          ),
          TextButton(
            onPressed: () {
              context.go(AppRouter.kWelcomeBack);
            },
            child: Text(
              text2,
              style: Styles.textStyleCom14.copyWith(
                fontWeight: FontWeight.w600,
                color: kWordColor,
                decoration: TextDecoration.underline, // ✅ خط تحت النص
              ),
            ),
          ),
        ],
      ),
    );
  }
}
