import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/orderChangeState/order_change_state_state.dart';
import 'package:petsica/features/profiles/seller/services/seller_orders_service.dart';

class SellerOrderCompleteCubit extends Cubit<SellerOrderCompleteState> {
  SellerOrderCompleteCubit() : super(SellerOrderCompleteInitial());

  Future<void> completeOrder(int sellerOrderId) async {
    emit(SellerOrderCompleteLoading());

    try {
      await SellerOrderService.makeOrderComplete(sellerOrderId);
      emit(SellerOrderCompleteSuccess());
    } catch (e) {
      emit(SellerOrderCompleteFailure(e.toString()));
    }
  }
}
