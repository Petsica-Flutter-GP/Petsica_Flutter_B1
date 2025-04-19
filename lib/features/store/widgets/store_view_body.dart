import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart'; // تأكد من استيراد الـ ProductCategory
import 'package:petsica/core/utils/styles.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/features/store/services/store_services.dart';
import 'package:petsica/features/store/widgets/product_card.dart';

enum ProductCategory { food, toys, accessories, healthcare }

extension ProductCategoryExtension on ProductCategory {
  String get name {
    switch (this) {
      case ProductCategory.food:
        return "Food";
      case ProductCategory.toys:
        return "Toys";
      case ProductCategory.accessories:
        return "Accessories";
      case ProductCategory.healthcare:
        return "Healthcare";
      default:
        return "Food";
    }
  }

  static ProductCategory fromString(String value) {
    switch (value) {
      case 'Food':
        return ProductCategory.food;
      case 'Toys':
        return ProductCategory.toys;
      case 'Accessories':
        return ProductCategory.accessories;
      case 'Healthcare':
        return ProductCategory.healthcare;
      default:
        return ProductCategory.food;
    }
  }
}

class StoreViewBody extends StatelessWidget {
  const StoreViewBody({super.key});

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
            onPressed: () {
              GoRouter.of(context).go(AppRouter.kCart);
            },
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 16, // add a shadow effect to the drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Custom Drawer Header with an image and title
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [kAddPetTextColor, kIconsColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  // Icon(
                  //   Icons.store,
                  //   size: 40,
                  //   color: Colors.white,
                  // ),
                  const SizedBox(width: 10),
                  Text('Categories',
                      style: Styles.textStyleCom32
                          .copyWith(color: kWhiteGroundColor)),
                ],
              ),
            ),
            // Display categories from the enum with icons
            ...ProductCategory.values.map((category) {
              return ListTile(
                leading: const Icon(
                  Icons.integration_instructions_rounded,
                  size: 23,
                  color: kBurgColor,
                ),
                title: Text(category.name, style: Styles.textStyleCom24),
                onTap: () {
                  // Add logic here for category filtering
                  // Example: filter products based on selected category
                },
                tileColor: Colors.white, // Add background color for items
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Rounded corners for tiles
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                hoverColor: Colors.blue[50], // Add hover effect
                focusColor: Colors.blue[100], // Focus effect
              );
            }),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Product>>(
          future: StoreService.getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Failed load data ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Products added yet'));
            }

            final products = snapshot.data!;

            return GridView.builder(
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
                    GoRouter.of(context).go(
                      AppRouter.kProductDetails,
                      extra: {
                        "name": products[index].productName,
                        "price": products[index].price.toString(),
                        "image": products[index].photo,
                      },
                    );
                  },
                  child: ProductCard(product: products[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
