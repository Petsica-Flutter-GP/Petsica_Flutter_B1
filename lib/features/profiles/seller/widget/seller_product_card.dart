import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/cubit/delete/product_deletion_cubit.dart';
import 'package:petsica/features/profiles/seller/cubit/git/seller_product_cubit.dart';
import 'package:petsica/features/profiles/seller/cubit/soldOut/soldout_cubit.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/features/profiles/seller/widget/seller_product_deletion_show_dialog.dart';

class SellerProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onDelete;

  const SellerProductCard({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  State<SellerProductCard> createState() => _SellerProductCardState();
}

class _SellerProductCardState extends State<SellerProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    Uint8List imageBytes = base64Decode(product.photo);

    return Container(
      decoration: BoxDecoration(
        color: kStoreContainerColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 3.5,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        color: kStoreContainerColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        imageBytes,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),

                  // طبقة سوداء نصف شفافة
                  if (!product.isAvailable)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),

                  // شارة حمراء متحركة
                  if (!product.isAvailable)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: ScaleTransition(
                        scale: _animation,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Sold out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                  // أزرار التحكم
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _showDeleteDialog(context),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black.withOpacity(0.5),
                            child: const Icon(Icons.close,
                                color: Colors.white, size: 18),
                          ),
                        ),
                        const SizedBox(height: 15),
                        if (product.isAvailable)
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).go(
                                AppRouter.kSellerEditProduct,
                                extra: product.productId,
                              );
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.black.withOpacity(0.5),
                              child: const Icon(Icons.edit,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                        if (product.isAvailable) const SizedBox(height: 15),
                        // GestureDetector(
                        //   onTap: () async {
                        //     await context
                        //         .read<SoldOutCubit>()
                        //         .markProductAsSoldOut(product.productId);

                        //     // 🟢 إعادة تحميل المنتجات بعد التحديث
                        //     context.read<SellerProductsCubit>().fetchProducts();

                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: Text(product.isAvailable
                        //             ? 'Product is now sold out'
                        //             : ' '),
                        //         duration: const Duration(seconds: 2),
                        //       ),
                        //     );
                        //     log("Product isAvailable: ${product.isAvailable}");
                        //   },
                        //   child: Visibility(
                        //     visible: product
                        //         .isAvailable, // إخفاء الأيقونة عندما يكون المنتج غير متاح
                        //     child: CircleAvatar(
                        //       radius: 15,
                        //       backgroundColor: Colors.black.withOpacity(0.5),
                        //       child: const Icon(Icons.checklist_sharp,
                        //           color: Colors.white, size: 18),
                        //     ),
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () async {
                            await context
                                .read<SoldOutCubit>()
                                .markProductAsSoldOut(product.productId);

                            // 🟢 إعادة تحميل المنتجات بعد التحديث
                            context.read<SellerProductsCubit>().fetchProducts();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(product.isAvailable
                                    ? 'Product is now sold out'
                                    : ' '),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            log("Product isAvailable: ${product.isAvailable}");
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black.withOpacity(0.5),
                            child: const Icon(Icons.checklist_sharp,
                                color: Colors.white, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // بيانات المنتج
            Padding(
              padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    product.productName,
                    style: Styles.textStyleCom18.copyWith(
                      color:
                          product.isAvailable ? kProductTxtColor : Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: Styles.textStyleCom16.copyWith(
                      color:
                          product.isAvailable ? kProductTxtColor : Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Tooltip(
                    message: product.description,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(color: Colors.white),
                    child: Text(
                      product.description,
                      style: Styles.textStyleCom16.copyWith(
                        color: product.isAvailable
                            ? kProductTxtColor
                            : Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price} EGP',
                        style: Styles.textStyleQui18.copyWith(
                          color: product.isAvailable
                              ? kProducPriceColor
                              : Colors.grey,
                          decoration: product.isAvailable
                              ? TextDecoration.none
                              : TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '${product.discount} %',
                        style: Styles.textStyleQui18.copyWith(
                          color: product.isAvailable
                              ? kProducPriceColor
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    SellerProductDeletionShowDialog(
      context,
      () {
        context
            .read<ProductDeletionCubit>()
            .deleteProduct(widget.product.productId);
        widget.onDelete();
      },
    );
  }
}
