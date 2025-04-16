import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/features/profiles/seller/widget/seller_product_deletion_show_dialog.dart';
import 'package:petsica/features/store/widgets/image_box.dart';

class SellerProductCard extends StatelessWidget {
  final String productName;
  final VoidCallback onDelete;

  const SellerProductCard({
    super.key,
    required this.productName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: ProductService.getSellerProducts(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); 
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No products available')); 
        } else {
          final product = snapshot.data!
              .firstWhere((product) => product.productName == productName,
                  orElse: () => Product(
                        productId: 0,
                        price: 0.0,
                        discount: 0.0,
                        description: 'No description',
                        quantity: 0,
                        productName: productName,
                        photo: '',
                        category: 'Unknown',
                      ));

          // Convert Base64 to Image
          Uint8List imageBytes = base64Decode(product.photo);

          return Container(
            decoration: BoxDecoration(
              color: kStoreContainerColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 4),
                  blurRadius: 3.5,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              color: kStoreContainerColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        Image.memory(
                          imageBytes,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showDeleteDialog(context);
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .go(AppRouter.kSellerEditProduct);
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          product.productName,
                          style: Styles.textStyleCom18
                              .copyWith(color: kProductTxtColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.category,
                          style: Styles.textStyleCom16
                              .copyWith(color: kProductTxtColor),
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
                            style: Styles.textStyleCom16
                                .copyWith(color: kProductTxtColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${product.price}',
                              style: Styles.textStyleQui18
                                  .copyWith(color: kProducPriceColor),
                            ),
                            Text(
                              '${product.discount} %',
                              style: Styles.textStyleQui18
                                  .copyWith(color: kProducPriceColor),
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
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    SellerProductDeletionShowDialog(context, onDelete);
  }
}
