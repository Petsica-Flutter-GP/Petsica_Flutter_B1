import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/getOrderByID/get_seller_order_by_id_state.dart';
import 'package:petsica/features/profiles/seller/services/seller_orders_service.dart';

class GetSellerOrderByIdCubit extends Cubit<GetSellerOrderByIdState> {
  GetSellerOrderByIdCubit() : super(GetSellerOrderByIdInitial());

  /// Fetches seller order details by ID
  Future<void> fetchSellerOrderById(int orderId) async {
    emit(GetSellerOrderByIdLoading());

    try {
      final order = await SellerOrderService.getSellerOrderByID(orderId);

      emit(GetSellerOrderByIdLoaded(order));
    } catch (error, stackTrace) {
      // Optional: Print or log the full error & stack trace for debugging
      print('❌ Error while fetching order by ID: $error');
      print(stackTrace);

      emit(const GetSellerOrderByIdError(
          '❌ Failed to load order. Please try again.'));
    }
  }
}
