// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_request_deletion_show_dialog.dart';

import '../../../../core/utils/asset_data.dart';
import '../../../../core/utils/styles.dart';

class AdminRequestsCardBigger extends StatelessWidget {
  final VoidCallback onDelete;

  const AdminRequestsCardBigger({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // ✅ الصورة
          ClipOval(
            child: Image.asset(
              AssetData.profileImage,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),

          // ✅ المسافة بين العناصر
          const SizedBox(width: 40),

          // ✅ زر Accept
          AppButton(
            text: 'Accept',
            style: Styles.textStyleCom16.copyWith(
              color: kWhiteGroundColor,
              fontWeight: FontWeight.bold,
            ),
            border: 10,
            width: 120,
            onTap: () {
              //TODO:
              // GoRouter.of(context).go(AppRouter.kAdminRequests);
            },
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              _showDeleteDialog(context);
            },
            icon: const Icon(
              Icons.highlight_off,
              color: kWordColor,
              size: 45,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    AdminRequestDeletionShowDialog(context, onDelete);
  }
}
