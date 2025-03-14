import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants.dart';

class AddressInputField extends StatelessWidget {
  final String label;
  final TextEditingController? controller; // ✅ Added controller
  final TextInputType keyboardType; // ✅ Allow different keyboard types

  const AddressInputField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType = TextInputType.text, // Default: normal text input
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          minLines: 1,
          maxLines: 5,
          decoration: InputDecoration(
            filled: true,
            fillColor: kInputFieldBackgroundColor,
            labelText: label,
            labelStyle: GoogleFonts.comfortaa(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: kInputWordColor,
            ),
            floatingLabelStyle: const TextStyle(
              color: kBurgColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            floatingLabelBehavior:
                FloatingLabelBehavior.auto, 

            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: kIconsColor, // ✅ تغيير اللون عندما يكون الحقل غير نشط
                width: 2, // ✅ تغيير سمك الخط
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: kBurgColor, // ✅ تغيير اللون عندما يكون الحقل نشطًا
                width: 3, // ✅ تغيير سمك الخط عند التركيز
              ),
            ),
          ),
        ));
  }
}
