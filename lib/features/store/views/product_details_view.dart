import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/storeC/getbyid/get_by_id_cubit.dart';
import 'package:petsica/features/store/widgets/product_details_view_body.dart';

class ProductDetailsView extends StatelessWidget {
  final int productId; // هنا نحدد المتغير productId

  ProductDetailsView({super.key, required this.productId}); // نمرر الباراميتر في constructor

  @override
  Widget build(BuildContext context) {
    // هنا يمكن استخدام productId في الـ BlocProvider
    return BlocProvider(
      create: (_) => ProductDetailsCubit()..fetchProductDetails(productId),
      child: const ProductDetailsViewBody(),
    );
  }
}
