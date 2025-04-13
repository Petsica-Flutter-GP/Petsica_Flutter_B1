import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsica/core/constants.dart';

class SellerCameraPlaceholder extends StatefulWidget {
  const SellerCameraPlaceholder({super.key});

  @override
  State<SellerCameraPlaceholder> createState() =>
      _SellerCameraPlaceholderState();
}

class _SellerCameraPlaceholderState extends State<SellerCameraPlaceholder> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: double.infinity,
          height: 230,
          decoration: BoxDecoration(
            color: kLightContainerColor,
            borderRadius: BorderRadius.circular(10),
            image: _imageFile != null
                ? DecorationImage(
                    image: FileImage(_imageFile!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: _imageFile == null
              ? const Icon(
                  Icons.image_rounded,
                  size: 90,
                  color: kIconsColor,
                )
              : null,
        ),
      ),
    );
  }
}
