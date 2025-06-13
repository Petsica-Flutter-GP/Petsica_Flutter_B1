import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/features/profiles/adminn/services/model/sitter_approval_model.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_request_deletion_show_dialog.dart';
import '../../../../core/utils/asset_data.dart';
import '../../../../core/utils/styles.dart';

class AdminRequestsCard extends StatelessWidget {
  final SitterApprovalModel sitter;
  final VoidCallback onDelete;
  final VoidCallback onAccept;

  const AdminRequestsCard({
    super.key,
    required this.sitter,
    required this.onDelete,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            leading: ClipOval(
              child: _buildImage(),
            ),
            title: Text(
              sitter.userName,
              style: Styles.textStyleCom22.copyWith(
                color: kBurgColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              sitter.address,
              style: Styles.textStyleCom16.copyWith(
                color: kProductTxtColor,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton(
                  text: 'Accept',
                  style: Styles.textStyleCom14.copyWith(
                    color: kWhiteGroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                  border: 10,
                  width: 75,
                  onTap: onAccept,
                ),
                const SizedBox(width: 15),
                IconButton(
                  onPressed: () {
                    _showDeleteDialog(context);
                  },
                  icon: const Icon(
                    Icons.close_outlined,
                    color: kWordColor,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (sitter.photo.isEmpty) {
      // 👉 مفيش صورة: نعرض الأيقونة
      return const Icon(
        Icons.person,
        size: 60,
        color: kWordColor,
      );
    }

    try {
      final decodedImage = base64Decode(sitter.photo);
      return Image.memory(
        decodedImage,
        height: 60,
        width: 60,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(
          Icons.person,
          size: 60,
          color: kWordColor,
        ),
      );
    } catch (_) {
      // 👉 الصورة مش صالحة: نعرض الأيقونة
      return const Icon(
        Icons.person,
        size: 60,
        color: Color.fromARGB(255, 138, 75, 80),
      );
    }
  }

  // /// ✅ دالة عرض الصورة سواء base64 أو placeholder
  // Widget _buildImage() {
  //   try {
  //     if (sitter.photo.isEmpty) {
  //       return const Icon(
  //         Icons.person,
  //         size: 60,
  //         color: kWordColor,
  //       );
  //     } else {
  //       final decodedImage = base64Decode(sitter.photo);
  //       return Image.memory(
  //         decodedImage,
  //         height: 60,
  //         width: 60,
  //         fit: BoxFit.cover,
  //         errorBuilder: (_, __, ___) => Image.asset(
  //           AssetData.profileImage,
  //           height: 60,
  //           width: 60,
  //           fit: BoxFit.cover,
  //         ),
  //       );
  //     }
  //   } catch (_) {
  //     return Image.asset(
  //       AssetData.profileImage,
  //       height: 60,
  //       width: 60,
  //       fit: BoxFit.cover,
  //     );
  //   }
  // }

  void _showDeleteDialog(BuildContext context) {
    AdminRequestDeletionShowDialog(context, onDelete);
  }
}
