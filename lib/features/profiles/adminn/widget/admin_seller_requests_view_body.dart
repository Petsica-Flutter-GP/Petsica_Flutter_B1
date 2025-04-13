import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_seller_requests_card.dart';

import '../../../../core/constants.dart';

class AdminSellerRequestsViewBody extends StatelessWidget {
  const AdminSellerRequestsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppColor,
      appBar: AppBar(
        title: Text("Seller requests", style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kAdminProfile),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        itemCount: 20,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // حطي هنا الإجراء اللي يصير لما يضغط على الكرت بالكامل
              print("Tapped card #$index");
              GoRouter.of(context).go(
                AppRouter.kAdminRequestDetails,
              );
            },
            child: AdminSellerRequestsCard(
              onDelete: () {
                // تنفيذ الحذف
                print("Deleted card #$index");
              },
            ),
          );
        },
      ),
    );
  }
}
