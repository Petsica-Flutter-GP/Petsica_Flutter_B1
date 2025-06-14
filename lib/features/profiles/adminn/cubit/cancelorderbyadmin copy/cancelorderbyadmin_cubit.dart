import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/cubit/cancelorderbyadmin%20copy/cancelorderbyadmin_state.dart';
import 'package:petsica/features/profiles/adminn/services/admin_services.dart';

class CancelOrderCubit extends Cubit<CancelOrderState> {
  CancelOrderCubit() : super(CancelOrderInitial());

  Future<void> cancelOrder(int orderId) async {
    emit(CancelOrderLoading());
    try {
      await AdminServices.cancelOrder(orderId); // ✅ تصحيح هنا
      emit(CancelOrderSuccess());
    } catch (e) {
      emit(CancelOrderFailure(e.toString().replaceAll('Exception: ', ''))); // ✅ شيل كلمة Exception
    }
  }
}
