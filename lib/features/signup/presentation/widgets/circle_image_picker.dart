import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CircleProfileImagePicker extends StatefulWidget {
  final File? image;
  final String? assetImage;
  final Function(File?)? onImageSelected;
  final String name;

  const CircleProfileImagePicker({
    super.key,
    this.image,
    this.assetImage,
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
        widget.onImageSelected?.call(newImage);
      }
    } catch (error) {
      debugPrint("Error picking image: ${error.toString()}");
    }
  }

  void _deleteImage() {
    if (_profileImage == null) return;

    setState(() => _profileImage = null);
    widget.onImageSelected?.call(null);
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
    final bool hasImage = _profileImage != null;
    final bool hasAsset = widget.assetImage != null;

    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[300],
          backgroundImage: hasImage
              ? FileImage(_profileImage!)
              : (hasAsset
                  ? AssetImage(widget.assetImage!) as ImageProvider
                  : null),
          child: (!hasImage && !hasAsset)
              ? const Icon(Icons.person, size: 60, color: Colors.white)
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
