import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/orderChangeState/order_change_state_cubit.dart';
import 'package:petsica/features/profiles/seller/cubit/orderChangeState/order_change_state_state.dart';
import 'package:petsica/features/profiles/seller/widget/seller_orders_view_body.dart';

class SellerOrdersView extends StatelessWidget {
  const SellerOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SellerOrderCompleteCubit(), 
      child: const SellerOrdersViewBody(),
    );
  }
}
