import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsica/core/constants.dart';

class VerificationIdInputField extends StatelessWidget {
  final Function(File?) onSelectImage;
  final String label;
  final TextEditingController? controller;

  const VerificationIdInputField({
    super.key,
    required this.onSelectImage,
    required this.label,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.comfortaa(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: kInputWordColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kStorkTextFieldColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kBurgColor, width: 1),
        ),
        floatingLabelStyle: const TextStyle(
          color: kBurgColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kStorkTextFieldColor, width: 1),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.camera_alt, color: kIconsColor),
          onPressed: () async {
            final picker = ImagePicker();
            final XFile? pickedImage =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedImage != null) {
              final file = File(pickedImage.path);
              controller?.text = pickedImage.name; // ✅ عرض اسم الصورة
              onSelectImage(file); // ✅ إرسال الصورة للكول باك
            }
          },
        ),
      ),
    );
  }
}
