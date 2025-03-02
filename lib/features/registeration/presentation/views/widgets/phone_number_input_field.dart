import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsica/core/constants.dart';
//added
class PhoneNumberInputField extends StatelessWidget {
  final String label;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const PhoneNumberInputField({
    super.key,
    required this.label,
    this.inputType,
    this.inputFormatters,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType ?? TextInputType.text,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.comfortaa(
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

        counterText: "", // إخفاء العداد السفلي
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.brown.shade300),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
