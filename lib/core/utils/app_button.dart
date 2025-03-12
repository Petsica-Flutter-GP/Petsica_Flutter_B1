// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constants.dart';
import 'styles.dart';

class AppButton extends StatelessWidget {
   AppButton({
    super.key,
    required this.text,
    required this.border,
     this.onTap,
  });

  final String text;
  final double border;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 262,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: kBurgColor, // لون الزر
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border),
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
