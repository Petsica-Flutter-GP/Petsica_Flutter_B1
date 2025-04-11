import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/widget/seller_product_card.dart';
import 'package:petsica/features/store/logic/cubit/cart_cubit.dart';
import 'package:petsica/features/store/widgets/category_drawer.dart';
import 'package:petsica/features/store/widgets/product_card.dart';

class SellerMyStoreViewBody extends StatelessWidget {
  SellerMyStoreViewBody({super.key});

  final List<String> products = [
    "Product Name 1",
    "Product Name 2",
    "Product Name 3",
    "Product Name 4",
    "Product Name 5",
    "Product Name 6",
    "Product Name 7",
    "Product Name 8",
    "Product Name 9",
    "Product Name 10",
    "Product Name 11",
    "Product Name 12",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My store", style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kSellerProfile),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).go(
                AppRouter.kSellerAddProduct,
              );
            },
            icon: const Icon(Icons.add_circle_outline),
            iconSize: 35,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: 0.6,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // GoRouter.of(context).go(
                //   AppRouter.kProductDetails,
                //   extra: {
                //     "name": products[index], // اسم المنتج (مؤقتًا)
                //     "price": "\$500", // السعر (قيمة تجريبية)
                //     "image": AssetData.productImage // صورة المنتج من الأصول
                //   },
                // );
              },
              child: SellerProductCard(
                productName: products[index],
                onDelete: () {
                  onDelete:
                  () {};
                  print("Product Deleted");
                },
              ),
            );
          },
        ),
      ),
    );
  }
}


      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Community"),
      //     BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.medical_services), label: "Service"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.local_hospital), label: "Clinic"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.notifications), label: "Alarm"),
      //   ],
      // ),