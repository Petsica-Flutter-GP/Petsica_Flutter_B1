import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String imagePath; // ✅ متغير الصورة

  const ImageBox({
    super.key,
    required this.imagePath, // ✅ تمرير الصورة كمطلوبة
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 160,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(
          //   width: 2, // سماكة الحدود
          //   color: Colors.grey, // لون الحدود
          // ),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
