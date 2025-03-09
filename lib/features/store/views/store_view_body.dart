import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/store/widgets/product_card.dart';

import '../widgets/category_drawer.dart';

class StoreViewBody extends StatelessWidget {
  StoreViewBody({super.key});

  final List<String> products = [
    "Product Name 1",
    "Product Name 2",
    "Product Name 3",
    "Product Name 4"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 35),
        title: Text(
          "Store",
          style: Styles.textStyleQu28,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, size: 35),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const CategoryDrawer(
        categories: ["Category1", "Category2", "Category3", "Category4"],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
              onTap: () {},
              child: ProductCard(productName: products[index]),
            );
          },
        ),
      ),
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
    );
  }
}
