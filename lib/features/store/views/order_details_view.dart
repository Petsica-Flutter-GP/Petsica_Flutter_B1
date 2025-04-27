import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/ordersC/userOrderDetails/userorderdetails_cubit.dart';
import 'package:petsica/features/store/widgets/order_details_view_body.dart';

class OrderDetailsView extends StatelessWidget {
  final int orderID;

  const OrderDetailsView({super.key, required this.orderID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserOrderDetailsCubit>(
      create: (context) => UserOrderDetailsCubit(),
      child: OrderDetailsViewBody(orderID: orderID),
    );
  }
}
