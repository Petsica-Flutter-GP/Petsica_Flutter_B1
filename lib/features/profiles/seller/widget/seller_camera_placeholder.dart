// import 'dart:io';
// import 'dart:convert'; // لتحويل Base64
// import 'dart:typed_data'; // لاستخدام Uint8List
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:petsica/core/constants.dart';

// class SellerCameraPlaceholder extends StatefulWidget {
//   final void Function(File? image)? onImageSelected;
//   final bool isImageRequired;
//   final ValueChanged<bool> onImageStatusChanged;

//   const SellerCameraPlaceholder({
//     super.key,
//     this.onImageSelected,
//     this.isImageRequired = false,
//     required this.onImageStatusChanged,
//   });

//   @override
//   State<SellerCameraPlaceholder> createState() =>
//       _SellerCameraPlaceholderState();
// }

// class _SellerCameraPlaceholderState extends State<SellerCameraPlaceholder> {
//   File? _imageFile;
//   bool _isImageSelected = false;

//   /// 🌀 دالة لتحويل الصورة إلى Base64
//   Future<void> convertImageToBase64(File imageFile) async {
//     Uint8List imageBytes = await imageFile.readAsBytes();
//     String base64String = base64Encode(imageBytes);
//     print("📦📦📦 Base64 Encoded Image:\n$base64String\n");
//     // ممكن تخزنيها في متغير أو تبعتيها في API حسب الحاجة
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedImage = await ImagePicker().pickImage(source: source);

//     if (pickedImage != null) {
//       final file = File(pickedImage.path);
//       setState(() {
//         _imageFile = file;
//         _isImageSelected = true;
//       });

//       // 🔁 نحول الصورة إلى Base64 بعد اختيارها
//       await convertImageToBase64(file);

//       widget.onImageSelected?.call(file);
//       widget.onImageStatusChanged(true);
//     }
//   }

//   void _showImagePickerOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Open camera'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pickImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Open gallery'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pickImage(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _removeImage() {
//     setState(() {
//       _imageFile = null;
//       _isImageSelected = false;
//     });
//     widget.onImageStatusChanged(false);
//     widget.onImageSelected?.call(null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hasError = widget.isImageRequired && _imageFile == null;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Stack(
//           children: [
//             GestureDetector(
//               onTap: _showImagePickerOptions,
//               child: Container(
//                 width: double.infinity,
//                 height: 230,
//                 decoration: BoxDecoration(
//                   color: kLightContainerColor,
//                   borderRadius: BorderRadius.circular(10),
//                   border: hasError
//                       ? Border.all(
//                           color: const Color.fromARGB(255, 179, 11, 25),
//                           width: 1.3)
//                       : Border.all(color: Colors.grey.shade300),
//                   image: _imageFile != null
//                       ? DecorationImage(
//                           image: FileImage(_imageFile!),
//                           fit: BoxFit.cover,
//                         )
//                       : null,
//                 ),
//                 child: _imageFile == null
//                     ? const Icon(
//                         Icons.image_rounded,
//                         size: 90,
//                         color: kIconsColor,
//                       )
//                     : null,
//               ),
//             ),
//             if (_imageFile != null)
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: GestureDetector(
//                   onTap: _removeImage,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.black54,
//                     ),
//                     padding: const EdgeInsets.all(6),
//                     child: const Icon(
//                       Icons.delete,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         if (hasError)
//           const Padding(
//             padding: EdgeInsets.only(top: 5),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 'Image is required',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 179, 11, 25), fontSize: 14),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

import 'dart:convert';
import 'dart:typed_data'; // لاستخدام Uint8List
import 'dart:io'; // لاستخدام File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsica/core/constants.dart';

class SellerCameraPlaceholder extends StatefulWidget {
  final void Function(File? image)? onImageSelected;
  final bool isImageRequired;
  final ValueChanged<bool> onImageStatusChanged;

  const SellerCameraPlaceholder({
    super.key,
    this.onImageSelected,
    this.isImageRequired = false,
    required this.onImageStatusChanged,
  });

  @override
  State<SellerCameraPlaceholder> createState() => _SellerCameraPlaceholderState();
}

class _SellerCameraPlaceholderState extends State<SellerCameraPlaceholder> {
  File? _imageFile;
  bool _isImageSelected = false;

  // دالة لتحويل الصورة إلى Base64
  String encodeImageToBase64(Uint8List imageBytes) {
    return base64Encode(imageBytes);
  }

  // دالة لفك تشفير Base64 إلى صورة
  Uint8List decodeBase64ToImage(String base64String) {
    return base64Decode(base64String);
  }

  // دالة لتحويل الصورة إلى Base64 بعد اختيارها
  Future<void> convertImageToBase64(File imageFile) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    String base64String = encodeImageToBase64(imageBytes); // استخدم الدالة هنا
    print("📦📦📦 Base64 Encoded Image:\n$base64String\n");
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      final file = File(pickedImage.path);
      setState(() {
        _imageFile = file;
        _isImageSelected = true;
      });

      // نحول الصورة إلى Base64 بعد اختيارها
      await convertImageToBase64(file);

      widget.onImageSelected?.call(file);
      widget.onImageStatusChanged(true);
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Open camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Open gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
      _isImageSelected = false;
    });
    widget.onImageStatusChanged(false);
    widget.onImageSelected?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.isImageRequired && _imageFile == null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: _showImagePickerOptions,
              child: Container(
                width: double.infinity,
                height: 230,
                decoration: BoxDecoration(
                  color: kLightContainerColor,
                  borderRadius: BorderRadius.circular(10),
                  border: hasError
                      ? Border.all(
                          color: const Color.fromARGB(255, 179, 11, 25),
                          width: 1.3)
                      : Border.all(color: Colors.grey.shade300),
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
            if (_imageFile != null)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: _removeImage,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (hasError)
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Image is required',
                style: TextStyle(
                    color: Color.fromARGB(255, 179, 11, 25), fontSize: 14),
              ),
            ),
          ),
      ],
    );
  }
}
