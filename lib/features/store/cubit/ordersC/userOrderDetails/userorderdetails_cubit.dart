import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/ordersC/userOrderDetails/userorderdetails_state.dart';
import 'package:petsica/features/store/services/order_services.dart';

class UserOrderDetailsCubit extends Cubit<UserOrderDetailsState> {
  UserOrderDetailsCubit() : super(UserOrderDetailsInitial());

  Future<void> fetchUserOrder(int orderID) async {
    try {
      emit(UserOrderDetailsLoading());

      final order = await OrderService.getUserOrderById(orderID);
      
      emit(UserOrderDetailsLoaded(order));
    } catch (e) {
      emit(UserOrderDetailsError(e.toString()));
    }
  }
}