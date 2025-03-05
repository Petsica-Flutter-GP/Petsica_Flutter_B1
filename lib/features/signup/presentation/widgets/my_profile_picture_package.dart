import 'package:flutter/material.dart';
import 'dart:math';

import 'package:petsica/core/constants.dart';

class MProfilePicture extends StatelessWidget {
  final String name;
  final double radius;
  final double fontsize;
  final bool tooltip;
  final bool random;
  final String? img;
  final Color? backgroundColor;

  const MProfilePicture({
    super.key,
    required this.name,
    required this.radius,
    required this.fontsize,
    this.tooltip = false,
    this.random = false,
    this.img,
    this.backgroundColor,
  });

  // دالة لاستخراج الحرف الأول من الاسم
  String _getInitials(String name) {
    List<String> words = name.trim().split(" ");
    if (words.length > 1) {
      return "${words[0][0]}${words[1][0]}".toUpperCase();
    }
    return words[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = CircleAvatar(
      radius: radius,
      backgroundColor: kStorkTextFieldColor,
      backgroundImage: img != null ? NetworkImage(img!) : null,
      child: img == null
          ? Text(
              _getInitials(name),
              style: TextStyle(
                fontSize: fontsize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          : null,
    );

    return tooltip
        ? Tooltip(
            message: name,
            child: avatar,
          )
        : avatar;
  }
}
