import 'package:flutter/material.dart';

import '../constants.dart';
import 'styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.border,
    this.onTap,
    this.width, // عرض الزر
    this.height, // ارتفاع الزر
  });

  final String text;
  final double border;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 262,
      height: height,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
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
