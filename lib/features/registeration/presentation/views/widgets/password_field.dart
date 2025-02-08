import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.text});
  final String text;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false; // ✅ للتحكم في إظهار/إخفاء كلمة المرور

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !_isPasswordVisible, // ✅ إخفاء/إظهار كلمة المرور
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: GoogleFonts.comfortaa(
          // ✅ تصحيح الخطأ هنا
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: kInputWordColor, // ✅ اللون الافتراضي
        ),
        floatingLabelStyle: const TextStyle(
          color: kBurgColor, // ✅ تغيير لون التسمية عند التركيز
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kBurgColor, // ✅ لون الحد عند التركيز
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kStorkTextFieldColor, // ✅ لون الحد في الوضع العادي
            width: 1,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xff4B4A4A), // ✅ لون الأيقونة
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
    );
  }
}
