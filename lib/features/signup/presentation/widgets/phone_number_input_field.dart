import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsica/core/constants.dart';

class PhoneNumberInputField extends StatelessWidget {
  final String label;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final VoidCallback?
      onPhoneIconPressed; // دالة يتم تمريرها عند الضغط على الأيقونة

  const PhoneNumberInputField({
    super.key,
    required this.label,
    this.inputType,
    this.inputFormatters,
    this.maxLength,
    this.onPhoneIconPressed, // استقبال الدالة
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
          color: kInputWordColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kBurgColor,
            width: 1,
          ),
        ),
        floatingLabelStyle: const TextStyle(
          color: kBurgColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kStorkTextFieldColor,
            width: 1,
          ),
        ),
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.brown.shade300),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        // ✅ إضافة أيقونة الهاتف
        suffixIcon: IconButton(
          icon: const Icon(Icons.phone, color: kIconsColor),
          onPressed: onPhoneIconPressed, // تنفيذ الدالة عند الضغط
        ),
      ),
    );
  }
}
