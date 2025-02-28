// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class UploadNationalID extends StatefulWidget {
//   const UploadNationalID({super.key});

//   @override
//   _UploadNationalIDState createState() => _UploadNationalIDState();
// }

// class _UploadNationalIDState extends State<UploadNationalID> {
//   File? _selectedImage;

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: InkWell(
//         onTap: _pickImage,
//         child: Container(
//           height: 55,
//           decoration: BoxDecoration(
//             color: Colors.brown.shade50,
//             border: Border.all(color: Colors.brown.shade300),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 child: Text(
//                   "National ID",
//                   style: TextStyle(color: Colors.black54, fontSize: 16),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 child: Icon(Icons.camera_alt, color: Colors.black54),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

