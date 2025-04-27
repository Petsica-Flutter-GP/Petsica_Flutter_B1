

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/getOrders/seller_orders_state.dart';
import 'package:petsica/features/profiles/seller/services/seller_orders_service.dart';

class SellerOrdersCubit extends Cubit<SellerOrdersState> {
  SellerOrdersCubit() : super(SellerOrdersInitial());

  Future<void> fetchSellerOrders() async {
    emit(SellerOrdersLoading());
    try {
      final orders = await SellerOrderService.getSellerOrders();
      emit(SellerOrdersSuccess(orders));
    } catch (e) {
      emit(SellerOrdersFailure(e.toString()));
    }
  }
}
