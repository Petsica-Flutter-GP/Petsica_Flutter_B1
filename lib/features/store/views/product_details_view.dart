import 'package:flutter/material.dart';
import 'package:petsica/core/utils/sign_up_arrow_back.dart';
import 'package:petsica/features/store/widgets/product_details_view_body.dart';

import '../../../core/utils/store_arrow_back.dart';

class ProductDetailsView extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductDetailsView({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const ProductDetailsViewBody());
  }
}
