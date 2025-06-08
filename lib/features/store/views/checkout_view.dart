import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/ordersC/userCancelOrder/usercancelorder_cubit.dart';
import 'package:petsica/features/store/cubit/ordersC/userorder/userorder_cubit.dart';
import 'package:petsica/features/store/widgets/checkout_view_body.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserOrderCubit()..fetchUserOrders()),
        BlocProvider(create: (_) => UserCancelOrderCubit()),
      ],
      child: const CheckOutViewBody(),
    );
  }
}
