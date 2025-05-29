import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants.dart';

class InputField extends StatefulWidget {
  final String label;
  final TextEditingController? controller; // ✅ Added controller
  final Widget? icon; // ✅ Optional icon
  final bool isPassword; // ✅ Support password fields
  final TextInputType keyboardType; // ✅ Allow different keyboard types
  final int? maxLength; // ✅ Optional maxLength
  final int? maxLines; // ✅ Optional maxLines
  final String? Function(String?)? validator; // ✅ Optional validator

  const InputField({
    super.key,
    required this.label,
    this.controller,
    this.icon,
    this.isPassword = false, // Default: not a password field
    this.keyboardType = TextInputType.text, // Default: normal text input
    this.maxLength, // Optional maxLength
    this.maxLines = 1, // Default: 1 line
    this.validator, // Optional validator
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _isRequired;

  @override
  void initState() {
    super.initState();
    _isRequired = false; // يبدأ بحالة غير مطلوبة

    // إضافة مستمع لتغيير الحالة بناءً على وجود نص في الـ TextEditingController
    widget.controller?.addListener(() {
      setState(() {
        _isRequired = widget.controller?.text.isEmpty ?? true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // ✅ Attach controller
      keyboardType: widget.keyboardType, // ✅ Set keyboard type
      obscureText: widget.isPassword, // ✅ Hide text if password
      maxLength: widget.maxLength, // ✅ Set maxLength if provided
      maxLines: widget.maxLines, // ✅ Set maxLines if provided
      validator: widget.validator, // ✅ Apply validator if provided
      decoration: InputDecoration(
        filled: true, // ✅ Makes the background filled
        fillColor: kInputFieldBackgroundColor, // ✅ Set background color
        labelText: widget.label,
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
        suffixIcon: widget.icon, // ✅ Show optional icon
        // تغيير لون الحدود أو حالة الـ label بناءً على الـ _isRequired
        errorText: _isRequired ? 'This field is required' : null,
      ),
    );
  }
}
