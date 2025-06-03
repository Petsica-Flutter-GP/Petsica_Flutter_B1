import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants.dart';

class PasswordField extends StatefulWidget {
  final String text;
  final TextEditingController? controller; // ✅ Added controller

  const PasswordField({
    super.key,
    required this.text,
    this.controller,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false; // ✅ Control password visibility

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller, // ✅ Attach controller
      obscureText: !_isPasswordVisible, // ✅ Toggle password visibility
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: GoogleFonts.comfortaa(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: kInputWordColor,
        ),
        floatingLabelStyle: const TextStyle(
          color: kBurgColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kBurgColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kStorkTextFieldColor,
            width: 1,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: kIconsColor,
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