
import 'package:flutter/material.dart';
//added
class VerificationIDField extends StatelessWidget {
  const VerificationIDField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Verification ID",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.brown.shade300),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.camera_alt, color: Colors.black54),
          onPressed: () {
            // TODO: إضافة كود اختيار الصورة من المعرض أو الكاميرا
          },
        ),
      ),
    );
  }
}
