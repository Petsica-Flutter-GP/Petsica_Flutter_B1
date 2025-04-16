import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/features/profiles/seller/widget/seller_product_card.dart';

class SellerMyStoreViewBody extends StatefulWidget {
  const SellerMyStoreViewBody({super.key});

  @override
  _SellerMyStoreViewBodyState createState() => _SellerMyStoreViewBodyState();
}

class _SellerMyStoreViewBodyState extends State<SellerMyStoreViewBody> {
  List<Product> products = []; // تخزين المنتجات التي يتم جلبها من الـ API
  bool isLoading = true; // لتتبع حالة التحميل
  String? errorMessage; // لتخزين رسالة الخطأ

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // استدعاء الدالة لتحميل المنتجات عند تحميل الصفحة
  }

  // دالة لجلب المنتجات من الـ API
  Future<void> _fetchProducts() async {
    try {
      final fetchedProducts = await ProductService.getSellerProducts();
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load products: $e'; // تحديث رسالة الخطأ
      });
    }
  }

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
        child: isLoading
            ? const Center(child: CircularProgressIndicator()) // عرض مؤشر تحميل عند جلب البيانات
            : errorMessage != null
                ? Center(child: Text(errorMessage!)) // عرض رسالة خطأ
                : GridView.builder(
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
                          // إضافة الوظيفة عند الضغط على المنتج
                        },
                        child: SellerProductCard(
                          productName: products[index].productName,
                          onDelete: () {
                            // إضافة عملية الحذف هنا
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
