// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constants.dart';
import 'styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
     this.backgroundColor,
    required this.border,
    this.width,
    this.height,
    this.onTap,
    this.style,
  }) : super(key: key);

  final String text;
  final Color? backgroundColor;
  final double border;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 262,
      height: height,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor??kBurgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: style ?? Styles.textStyleQui20.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
