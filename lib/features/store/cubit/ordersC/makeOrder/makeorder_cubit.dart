import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/ordersC/makeOrder/makeorder_state.dart';
import 'package:petsica/features/store/services/order_services.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  Future<void> makeOrder(String address) async {
    emit(OrderLoading());
    try {
      await OrderService.makeOrder(address);
      emit(OrderSuccess());
    } catch (e) {
      log('Order Error: $e');
      emit(OrderError(e.toString()));
    }
  }
}
