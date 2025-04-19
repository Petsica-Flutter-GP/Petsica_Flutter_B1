import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/cubit/delete/product_deletion_cubit.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/features/profiles/seller/widget/seller_product_deletion_show_dialog.dart';

class SellerProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;

  const SellerProductCard({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // تحويل الصورة من Base64
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
            // 📸 صورة المنتج
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
                  // 🛠️ أزرار الحذف والتعديل
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
                            child: const Icon(Icons.close, color: Colors.white, size: 18),
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).go(AppRouter.kSellerEditProduct,extra: product.productId);
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black.withOpacity(0.5),
                            child: const Icon(Icons.edit, color: Colors.white, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 📝 معلومات المنتج
            Padding(
              padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    product.productName,
                    style: Styles.textStyleCom18.copyWith(color: kProductTxtColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: Styles.textStyleCom16.copyWith(color: kProductTxtColor),
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
                      style: Styles.textStyleCom16.copyWith(color: kProductTxtColor),
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
                        style: Styles.textStyleQui18.copyWith(color: kProducPriceColor),
                      ),
                      Text(
                        '${product.discount} %',
                        style: Styles.textStyleQui18.copyWith(color: kProducPriceColor),
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
      context.read<ProductDeletionCubit>().deleteProduct(product.productId);
      onDelete(); // هذا علشان يحصل refresh للواجهة بعد الحذف
    },
  );
}

}
