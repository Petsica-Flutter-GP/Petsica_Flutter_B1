import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/features/signup/presentation/widgets/my_profile_picture_package.dart';
class CircleProfileImagePicker extends StatefulWidget {
  final File? image;
  final String? assetImage; // دعم الصور من assets
  final Function(File?)? onImageSelected;
  final String name;

  const CircleProfileImagePicker({
    super.key,
    this.image,
    this.assetImage, // جديد
    required this.name,
     this.onImageSelected,
  });

  @override
  _CircleProfileImagePickerState createState() =>
      _CircleProfileImagePickerState();
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

      final newImage = File(image.path);
      if (mounted) {
        setState(() => _profileImage = newImage);
        widget.onImageSelected!(newImage);
      }
    } catch (error) {
      debugPrint("Error picking image: ${error.toString()}");
    }
  }

  void _deleteImage() {
    if (_profileImage == null) return;

    setState(() => _profileImage = null);
    widget.onImageSelected!(null);
    Navigator.pop(context);
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Wrap(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[300],
          backgroundImage: _profileImage != null
              ? FileImage(_profileImage!) // ✅ إذا كانت الصورة من المعرض أو الكاميرا
              : (widget.assetImage != null
                  ? AssetImage(widget.assetImage!) as ImageProvider // ✅ إذا كانت الصورة من `assets`
                  : null),
          child: (_profileImage == null && widget.assetImage == null)
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
          child: InkWell(
            onTap: () => _showImageSourceDialog(context),
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
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
