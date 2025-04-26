import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/ordersC/userorder/userorder_state.dart';
import 'package:petsica/features/store/models/user_order_model.dart';
import 'package:petsica/features/store/services/order_services.dart';


class UserOrderCubit extends Cubit< UserOrderState> {
   UserOrderCubit() : super( UserOrderInitial());

  Future<void> fetchUserOrders() async {
    emit( UserOrderLoading());
    try {
      final List<UserOrderModel> orders = await OrderService.getUserOrders();
      emit( UserOrderLoaded(orders));
    } catch (e) {
      emit( UserOrderError(e.toString()));
    }
  }
}
