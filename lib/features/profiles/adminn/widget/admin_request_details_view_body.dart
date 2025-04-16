import 'package:flutter/material.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_request_deletion_show_dialog.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_requests_card_Bigger.dart';
import '../../../../core/constants.dart';

class AdminSellerRequestDetailsViewBody extends StatelessWidget {
  const AdminSellerRequestDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteGroundColor,
      appBar: AppBar(
        title: Text("Request details", style: Styles.textStyleQu28),
        centerTitle: true,
        leading:
            const AppArrowBack(destination: AppRouter.kAdminProfile), //TODO
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdminRequestsCardBigger(
              onDelete: () => _showDeleteDialog(context),
            ),
            _detailsInfo('User name', 'user 1'),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            _detailsInfo('Email', 'user@gmail.com'),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            _detailsInfo('Phone number', '0123445'),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            _detailsInfo('Location', 'Fayoum'),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            _detailsInfo('Working hours', '1:00 to 5:00'),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                AssetData.productImage,
                height: 300,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _detailsInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.textStyleCom28.copyWith(color: kBurgColor),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Styles.textStyleCom22,
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    AdminRequestDeletionShowDialog(
      context,
      () {
        print("Deleted");
      },
    );
  }
}
