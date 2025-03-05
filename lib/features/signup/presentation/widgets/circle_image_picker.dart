import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/features/signup/presentation/widgets/my_profile_picture_package.dart';

class CircleProfileImagePicker extends StatefulWidget {
  final File? image;
  final Function(File?) onImageSelected;
  final String name;

  const CircleProfileImagePicker({
    super.key,
    required this.image,
    required this.name,
    required this.onImageSelected,
  });

  @override
  _CircleProfileImagePickerState createState() => _CircleProfileImagePickerState();
}

class _CircleProfileImagePickerState extends State<CircleProfileImagePicker> {
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _profileImage = widget.image;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() {
        _profileImage = File(image.path);
      });
      widget.onImageSelected(_profileImage);
    } catch (error) {
      print(error);
    }
  }

  void _deleteImage() {
    setState(() {
      _profileImage = null;
    });
    widget.onImageSelected(null);
    Navigator.pop(context); // إغلاق النافذة بعد الحذف
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Upload From Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            if (_profileImage != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete Image',
                    style: TextStyle(color: Colors.red)),
                onTap: _deleteImage,
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[300],
          backgroundImage:
              _profileImage != null ? FileImage(_profileImage!) : null,
          child: _profileImage == null
              ? MProfilePicture(
                  name: widget.name,
                  backgroundColor: kBurgColor,
                  radius: 60,
                  fontsize: 42,
                )
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => _showImageSourceDialog(context),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                // border: Border.all(color: Colors.grey),
              ),
              child: const Icon(
                Icons.border_color,
                color: Colors.black54,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
