import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/widget/seller_order_details_view_body.dart';
import 'package:petsica/features/profiles/seller/cubit/getOrderByID/get_seller_order_by_id_cubit.dart';

class SellerOrdersDetailsView extends StatelessWidget {
  final int orderId; // 🟡 تأكدي من تمرير الـ orderId عند التنقل للصفحة

  const SellerOrdersDetailsView({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetSellerOrderByIdCubit()..fetchSellerOrderById(orderId ),
      child: const SellerOrderDetailsViewBody(),
    );
  }
}
