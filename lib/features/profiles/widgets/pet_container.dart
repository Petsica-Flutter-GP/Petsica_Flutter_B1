// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:petsica/core/constants.dart';
// import 'package:petsica/core/utils/app_router.dart';
// import 'package:petsica/core/utils/asset_data.dart';
// import 'package:petsica/features/profiles/model/get_pet_model.dart';
// import '../../../core/utils/styles.dart';

// class PetContainer extends StatelessWidget {
//   final GetPetModel pet;

//   const PetContainer({super.key, required this.pet});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         GoRouter.of(context).go(
//           AppRouter.kPetDetails,
//           extra: pet,
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//         padding: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               kAddPetContainerColor.withOpacity(0.8),
//               Colors.white.withOpacity(0.5)
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               spreadRadius: 1,
//               blurRadius: 3,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(52),
//               child: pet.photo.isNotEmpty
//                   ? Image.memory(
//                       base64Decode(pet.photo),
//                       width: 80,
//                       height: 80,
//                       fit: BoxFit.cover,
//                     )
//                   : Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.red),
//                         borderRadius:
//                             BorderRadius.circular(52),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 6,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.error,
//                         color: Colors.red,
//                         size: 40, // حجم الأيقونة
//                       ),
//                     ),
//             ),
//             const SizedBox(width: 15),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     pet.name,
//                     style: Styles.textStyleCom22.copyWith(
//                         color: kProductTxtColor, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 5),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/model/get_pet_model.dart';
import 'package:petsica/features/profiles/model/post_pet_model.dart';

class PetContainer extends StatelessWidget {
  final GetPetModel pet;

  const PetContainer({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildPetImage(pet.photo),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name ?? 'Unknown Name',
                    style: Styles.textStyleCom22.copyWith(
                      color: kProductTxtColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pet.gender ?? 'Unknown Type',
                    style: Styles.textStyleCom16.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Widget لعرض صورة الحيوان الأليف مع fallback في حال الخطأ
  Widget _buildPetImage(String? base64Image) {
    if (base64Image == null || base64Image.isEmpty) {
      return _defaultImage();
    }

    try {
      // ✅ تأكد من الطول الصحيح بإضافة padding إذا احتاج
      String fixedBase64 = base64Image.padRight(
        base64Image.length + ((4 - base64Image.length % 4) % 4),
        '=',
      );
      final bytes = base64Decode(fixedBase64);
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          bytes,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      );
    } catch (e) {
      return _defaultImage();
    }
  }

  /// 🎯 صورة افتراضية إذا فشلنا في عرض الصورة الأصلية
  Widget _defaultImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.pets,
        size: 36,
        color: Colors.white,
      ),
    );
  }
}
