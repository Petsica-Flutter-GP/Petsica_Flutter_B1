
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetSellerService%20copy/admin_get_seller_service_state.dart';
import 'package:petsica/features/profiles/adminn/services/admin_profile_services.dart';

class SellerApprovalCubit extends Cubit<SellerApprovalState> {
  SellerApprovalCubit() : super(SellerApprovalInitial());

  Future<void> fetchSellerApprovals() async {
    emit(SellerApprovalLoading());

    try {
      final SellerList = await AdminProfileServices.getSellerApprovals(); // غيري الاسم حسب مكان الدالة
      emit(SellerApprovalSuccess(SellerList));
    } catch (e) {
      emit(SellerApprovalFailure(e.toString()));
    }
  }

Future<void> approveSeller(String userId) async {
  try {
    emit(SellerApprovalLoading());

    await AdminProfileServices.approve(userId);

    // بعد ما يوافق، نعيد تحميل القائمة
    final updatedList = await AdminProfileServices.getSellerApprovals();
    emit(SellerApprovalSuccess(updatedList));
  } catch (e) {
    emit(SellerApprovalFailure(e.toString()));
  }
}


}
