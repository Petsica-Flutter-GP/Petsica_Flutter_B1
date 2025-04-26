import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/ordersC/makeOrder/makeorder_state.dart';
import 'package:petsica/features/store/services/order_services.dart';

class MakeOrderCubit extends Cubit<MakeOrderState> {
  MakeOrderCubit() : super(MakeOrderInitial());

  Future<void> makeOrder(String address) async {
    emit(MakeOrderLoading());
    try {
      await OrderService.makeOrder(address);
      emit(MakeOrderSuccess());
    } catch (e) {
      log('Order Error: $e');
      emit(MakeOrderError(e.toString()));
    }
  }
}
