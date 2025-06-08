import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/ordersC/userCancelOrder/usercancelorder_state.dart';
import 'package:petsica/features/store/services/order_services.dart';

class UserCancelOrderCubit extends Cubit<UserCancelOrderState> {
  UserCancelOrderCubit() : super(UserCancelOrderInitial());

  Future<void> cancelOrder(int orderId) async {
    emit(UserCancelOrderLoading());

    try {
      await OrderService.cancelOrderByUser(orderId);
      emit(UserCancelOrderSuccess());
    } catch (e) {
      emit(UserCancelOrderFailure(e.toString()));
    }
  }
}
