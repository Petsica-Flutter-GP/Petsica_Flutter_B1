import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/cubit/completeorderbyadmin%20copy/completeorderbyadmin_cubit.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_seller_orders_view_body.dart';

class AdminSellerOrdersView extends StatelessWidget {
  const AdminSellerOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompleteOrderCubit(),
      child: const AdminSellerOrderViewBody(),
    );
  }
}
