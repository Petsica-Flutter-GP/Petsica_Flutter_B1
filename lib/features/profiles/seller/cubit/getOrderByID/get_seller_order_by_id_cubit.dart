

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/getOrderByID/get_seller_order_by_id_state.dart';
import 'package:petsica/features/profiles/seller/services/seller_orders_service.dart';

class GetSellerOrderByIdCubit extends Cubit<GetSellerOrderByIdState> {
  GetSellerOrderByIdCubit() : super(GetSellerOrderByIdInitial());

  Future<void> fetchSellerOrderById(int id) async {
    emit(GetSellerOrderByIdLoading());

    try {
      final order = await SellerOrderService.getSellerOrderByID(id);
      emit(GetSellerOrderByIdLoaded(order));
    } catch (e) {
      emit(GetSellerOrderByIdError('Failed to load seller order'));
    }
  }
}
