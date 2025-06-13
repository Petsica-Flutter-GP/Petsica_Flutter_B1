import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/cubit/completeorderbyadmin/completeorderbyadmin_state.dart';
import 'package:petsica/features/profiles/adminn/services/admin_services.dart';

class CompleteOrderCubit extends Cubit<CompleteOrderState> {
  CompleteOrderCubit() : super(CompleteOrderInitial());

  Future<void> completeOrder(int orderId) async {
    emit(CompleteOrderLoading());
    try {
      await AdminServices.completeOrder(orderId); // ✅ تصحيح هنا
      emit(CompleteOrderSuccess());
    } catch (e) {
      emit(CompleteOrderErrorState(
          e.toString().replaceAll('Exception: ', ''))); // ✅ شيل كلمة Exception
    }
  }
}
