import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsica/core/constants.dart';

class PhoneNumberInputField extends StatelessWidget {
  final String label;
  final TextEditingController? controller; // ✅ Added controller
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final VoidCallback? onPhoneIconPressed; // ✅ Handles phone icon press

  const PhoneNumberInputField({
    super.key,
    required this.label,
    this.controller, // ✅ Accept controller
    this.inputType,
    this.inputFormatters,
    this.maxLength,
    this.onPhoneIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // ✅ Use controller
      keyboardType: inputType ?? TextInputType.phone,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        // ✅ Phone icon button
        suffixIcon: IconButton(
          icon: const Icon(Icons.phone, color: kIconsColor),
          onPressed: onPhoneIconPressed, // ✅ Trigger callback
        ),
      ),
    );
  }
}