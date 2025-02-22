import 'package:flutter/material.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/utils/styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 262,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: kBurgColor, // لون الزر
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          text,
          style: Styles.textStyleQui20.copyWith(color: Colors.white),
          textAlign: TextAlign.center, // ✅ توسيط النص
        ),
      ),
    );
  }
}
