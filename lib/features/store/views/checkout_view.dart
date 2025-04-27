import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // لازم نضيف هذه المكتبة
import 'package:petsica/features/store/cubit/ordersC/userorder/userorder_cubit.dart';
import 'package:petsica/features/store/widgets/checkout_view_body.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    // هنا هنقوم بتوفير الـ Cubit الخاص بالطلبات
    return BlocProvider(
      create: (_) =>
          UserOrderCubit()..fetchUserOrders(), // جلب الطلبات الخاصة بالمستخدم
      child: const CheckOutViewBody(),
    );
  }
}
