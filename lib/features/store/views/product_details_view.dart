import 'package:flutter/material.dart';
import 'package:petsica/features/store/widgets/product_details_view_body.dart';


class ProductDetailsView extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductDetailsView({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ProductDetailsViewBody());
  }
}
