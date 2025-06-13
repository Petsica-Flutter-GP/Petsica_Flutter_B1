import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetClinicService%20copy/admin_get_clinic_service_state.dart';
import 'package:petsica/features/profiles/adminn/services/admin_profile_services.dart';

class ClinicApprovalCubit extends Cubit<ClinicApprovalState> {
  ClinicApprovalCubit() : super(ClinicApprovalInitial());

  Future<void> fetchClinicApprovals() async {
    emit(ClinicApprovalLoading());

    try {
      final ClinicList = await AdminProfileServices.getClinicApprovals(); // غيري الاسم حسب مكان الدالة
      emit(ClinicApprovalSuccess(ClinicList));
    } catch (e) {
      emit(ClinicApprovalFailure(e.toString()));
    }
  }

Future<void> approveClinic(String userId) async {
  try {
    emit(ClinicApprovalLoading());

    await AdminProfileServices.approve(userId);

    // بعد ما يوافق، نعيد تحميل القائمة
    final updatedList = await AdminProfileServices.getClinicApprovals();
    emit(ClinicApprovalSuccess(updatedList));
  } catch (e) {
    emit(ClinicApprovalFailure(e.toString()));
  }
}


}
