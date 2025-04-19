
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
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
                    style:
                        Styles.textStyleCom18.copyWith(color: kProductTxtColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style:
                        Styles.textStyleCom16.copyWith(color: kProductTxtColor),
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
                        '${product.price} EGP',
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


}
