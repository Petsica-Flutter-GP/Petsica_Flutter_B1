import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/services/admin_services.dart';
import 'getsellerordersbyadmin_state.dart';

class AdminSellerOrdersCubit extends Cubit<AdminSellerOrdersState> {
  AdminSellerOrdersCubit() : super(AdminSellerOrderInitial());

  Future<void> fetchSellerOrders() async {
    emit(AdminSellerOrderLoading());

    try {
      final orders = await AdminServices.getAllSellerOrders();

      emit(AdminSellerOrderLoaded(orders));
    } catch (e) {
      emit(AdminSellerOrderError('Failed to fetch seller orders: ${e.toString()}'));
    }
  }
}
