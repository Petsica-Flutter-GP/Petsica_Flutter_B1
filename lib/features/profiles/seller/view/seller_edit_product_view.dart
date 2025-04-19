import 'package:flutter/material.dart';
import 'package:petsica/features/profiles/seller/widget/seller_edit_product_view_body.dart';

class SellerEditProductView extends StatelessWidget {
  final int productId;

  // تعديل الكود لتمرير معرّف المنتج
  const SellerEditProductView({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return SellerEditProductViewBody(productId: productId);
  }
}
