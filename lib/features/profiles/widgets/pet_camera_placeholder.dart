import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsica/core/constants.dart';

class PetCameraPlaceholder extends StatefulWidget {
  const PetCameraPlaceholder({super.key});

  @override
  State<PetCameraPlaceholder> createState() => _PetCameraPlaceholderState();
}

class _PetCameraPlaceholderState extends State<PetCameraPlaceholder> {
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
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey[300],
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
                  color: kAccountColor,
                )
              : null,
        ),
      ),
    );
  }
}
