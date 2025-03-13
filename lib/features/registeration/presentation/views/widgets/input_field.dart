import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController? controller; // ✅ Added controller
  final Widget? icon; // ✅ Optional icon
  final bool isPassword; // ✅ Support password fields
  final TextInputType keyboardType; // ✅ Allow different keyboard types

  const InputField({
    super.key,
    required this.label,
    this.controller,
    this.icon,
    this.isPassword = false, // Default: not a password field
    this.keyboardType = TextInputType.text, // Default: normal text input
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // ✅ Attach controller
      keyboardType: keyboardType, // ✅ Set keyboard type
      obscureText: isPassword, // ✅ Hide text if password
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
        suffixIcon: icon, // ✅ Show optional icon
      ),
    );
  }
}
