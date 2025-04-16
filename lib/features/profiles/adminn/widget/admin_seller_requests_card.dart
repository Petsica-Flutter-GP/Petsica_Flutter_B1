// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_request_deletion_show_dialog.dart';
import '../../../../core/utils/asset_data.dart';
import '../../../../core/utils/styles.dart';

class AdminSellerRequestsCard extends StatelessWidget {
  final VoidCallback onDelete;

  const AdminSellerRequestsCard({
    Key? key,
    required this.onDelete,
  }) : super(key: key);

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
              child: Image.asset(
                AssetData.profileImage,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'User Name',
              style: Styles.textStyleCom22.copyWith(
                color: kBurgColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Fayoum',
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
                  onTap: () {
                    // GoRouter.of(context).go(
                    //   AppRouter.kSellerOrderDetails,
                    // );
                  },
                ),
                const SizedBox(width: 15),
                IconButton(
                  onPressed: () {
                    _showDeleteDialog(context);
                    print("Item Deleted");
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

  // ✅ دالة داخل الكلاس وتقدر توصل للـ onDelete
  void _showDeleteDialog(BuildContext context) {
    AdminRequestDeletionShowDialog(context, onDelete);
  }
}
