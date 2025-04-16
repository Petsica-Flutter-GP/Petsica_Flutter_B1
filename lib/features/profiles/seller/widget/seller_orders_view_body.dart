import 'package:flutter/material.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/widget/seller_orders_card.dart';
import '../../../../core/constants.dart';

class SellerOrdersViewBody extends StatelessWidget {
  const SellerOrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppColor,
      appBar: AppBar(
        title: Text("My orders", style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kSellerProfile),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        itemCount: 20, // عدديهم حسب الحاجة
        itemBuilder: (context, index) {
          return const SellerOrdersCard();
          
        },
      ),
    );
  }
}
