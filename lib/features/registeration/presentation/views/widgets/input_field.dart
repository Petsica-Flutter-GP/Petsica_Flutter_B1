import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants.dart';

class InputField extends StatelessWidget {
  const InputField({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: text,
        labelStyle: GoogleFonts.comfortaa(
          // ✅ تصحيح الخطأ هنا
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: kInputWordColor, // ✅ اللون الافتراضي
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kBurgColor, // ✅ لون الحد عند التركيز
            width: 1,
          ),
        ),
        floatingLabelStyle: const TextStyle(
          color: kBurgColor, // ✅ تغيير لون كلمة "Username" عند التركيز
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kStorkTextFieldColor, // ✅ لون الحد في الوضع العادي
            width: 1,
          ),
        ),
      ),
    );
  }
}
