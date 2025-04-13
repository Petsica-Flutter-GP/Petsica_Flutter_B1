import 'package:flutter/material.dart';

import '../constants.dart';
import 'styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.backgroundColor,
    required this.border,
    this.width,
    this.height,
    this.onTap,
    this.style,
    this.borderColor,
  });

  final String text;
  final Color? backgroundColor;
  final double border;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final TextStyle? style;
  final Color? borderColor; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 262,
      height: height,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? kBurgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border),
            side: BorderSide(
              color: borderColor ?? Colors.transparent, 
              width: 2,
            ),
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
