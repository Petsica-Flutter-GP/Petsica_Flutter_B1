import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsica/core/constants.dart';

class AppDropDownButton extends StatelessWidget {
  const AppDropDownButton({
    super.key,
    required this.labelText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator, // إضافة validator للحقل
    this.color, 
  });

  final String labelText;
  final List<String> items;
  final String value;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator; // validator لتخصيص التحقق
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              color:color?? kInputWordColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator, // استخدام الـ validator إذا كان موجودًا
      decoration: InputDecoration(
        filled: true,
        fillColor: kInputFieldBackgroundColor, // الخلفية
        labelText: labelText,
        labelStyle: GoogleFonts.comfortaa(
          fontSize: 16,
          fontWeight: FontWeight.normal,
              color:color?? kInputWordColor,
        ),
        floatingLabelStyle:  TextStyle(
              color:color?? kInputWordColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // تغيير الحواف
          borderSide:  BorderSide(
              color:color?? kInputWordColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(
              color:color?? kInputWordColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}
