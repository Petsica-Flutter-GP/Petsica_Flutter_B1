import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/features/store/cubit/getbycategory/getbycategory_cubit.dart';
import 'package:petsica/features/store/cubit/getbycategory/getbycategory_state.dart';
import 'package:petsica/features/store/services/store_services.dart';
import 'package:petsica/features/store/widgets/product_card.dart';
import 'package:shimmer/shimmer.dart'; // استيراد مكتبة Shimmer

// Enum for ProductCategory
enum ProductCategory { all, food, toys, accessories, healthcare }

extension ProductCategoryExtension on ProductCategory {
  String get name {
    switch (this) {
      case ProductCategory.all:
        return "All";
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
      case 'All':
        return ProductCategory.all;
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

class StoreViewBody extends StatefulWidget {
  const StoreViewBody({super.key});

  @override
  _StoreViewBodyState createState() => _StoreViewBodyState();
}

class _StoreViewBodyState extends State<StoreViewBody> {
  ProductCategory selectedCategory = ProductCategory.food; // الفئة الافتراضية
  late Future<List<Product>> productFuture;

  @override
  void initState() {
    super.initState();
    productFuture = StoreService.getByCategory(
        selectedCategory.name); // جلب المنتجات بناءً على الفئة الافتراضية
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 35),
        title: Text("Store", style: Styles.textStyleQu28),
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
        elevation: 16,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
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
                  const SizedBox(width: 10),
                  Text('Categories',
                      style: Styles.textStyleCom32
                          .copyWith(color: kWhiteGroundColor)),
                ],
              ),
            ),
            ...ProductCategory.values.map((category) {
              return ListTile(
                leading: const Icon(Icons.integration_instructions_rounded,
                    size: 23, color: kBurgColor),
                title: Text(category.name, style: Styles.textStyleCom24),
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                    productFuture = (category == ProductCategory.all)
                        ? StoreService
                            .getAll() // استرجاع كل المنتجات إذا كانت الفئة هي "All"
                        : StoreService.getByCategory(category
                            .name); // استرجاع المنتجات حسب الفئة المحددة
                  });
                  Navigator.pop(context); // إغلاق الدrawer بعد الاختيار
                },
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              );
            }),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Product>>(
          future: productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.6,
                ),
                itemCount: 6, // عدد العناصر أثناء التحميل
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: kProducPriceColor.withOpacity(0.2),
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Card(
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 150,
                              color: Colors.grey[300],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.grey[300],
                                    height: 20,
                                    width: 100,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    color: Colors.grey[300],
                                    height: 20,
                                    width: 80,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    color: Colors.grey[300],
                                    height: 20,
                                    width: double.infinity,
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        color: Colors.grey[300],
                                        height: 20,
                                        width: 50,
                                      ),
                                      Container(
                                        color: Colors.grey[300],
                                        height: 20,
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
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
        extra: products[index].productId, // ✅ تمرير ID كـ int
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
