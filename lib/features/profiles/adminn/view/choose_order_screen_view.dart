import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';

class ChooseOrderScreen extends StatelessWidget {
  const ChooseOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ألوان وزخارف يمكن تعديلها حسب ذوقك
    final containerDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    );

    const textStyleTitle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: kBurgColor,
    );

    final textStyleSubtitle = TextStyle(
      fontSize: 16,
      color: Colors.grey[700],
    );

    return Scaffold(
      appBar: AppBar(
        leading: const AppArrowBack(destination: AppRouter.kAdminProfile),
        title: Text('Choose Order Type', style: Styles.textStyleCom22),
        centerTitle: true,
        // backgroundColor: const Color.fromARGB(255, 187, 142, 146),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // الحاوية الأولى: All Orders
            GestureDetector(
              onTap: () {
                // هنا حط التوجيه لصفحة All Orders
                GoRouter.of(context).go(
                  AppRouter.kAdminAllOrders,
                );
              },
              child: Container(
                decoration: containerDecoration,
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    const Icon(Icons.list_alt, size: 50, color: kBurgColor),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('All Orders', style: textStyleTitle),
                          const SizedBox(height: 6),
                          Text(
                            'View all orders for all sellers.',
                            style: textStyleSubtitle,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: kBurgColor),
                  ],
                ),
              ),
            ),

            // الحاوية الثانية: Seller Orders
            GestureDetector(
              onTap: () {
                // هنا حط التوجيه لصفحة Seller Orders
                GoRouter.of(context).go(AppRouter.kAdminSellerOrders);
              },
              child: Container(
                decoration: containerDecoration,
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart,
                        size: 50, color: kBurgColor),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Seller Orders', style: textStyleTitle),
                          const SizedBox(height: 6),
                          Text(
                            'View orders related to a specific seller.',
                            style: textStyleSubtitle,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: kBurgColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
