

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetSitterService/admin_get_sitter_service_state.dart';
// import 'package:petsica/features/profiles/adminn/services/admin_profile_services.dart';

// class AdminSitterServicesCubit extends Cubit<AdminSitterServicesState> {
//   AdminSitterServicesCubit() : super(AdminSitterServicesInitial());

//   static AdminSitterServicesCubit get(context) => BlocProvider.of(context);

//   Future<void> adminfetchSitterServices() async {
//     emit(AdminSitterServicesLoading());

//     try {
//       final services = await AdminProfileServices.getSitterServices();
//       emit(AdminSitterServicesLoaded(services));
//     } catch (e) {
//       emit(AdminSitterServicesError(e.toString()));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetSitterService/admin_get_sitter_service_state.dart';
import 'package:petsica/features/profiles/adminn/services/admin_profile_services.dart';

class SitterApprovalCubit extends Cubit<SitterApprovalState> {
  SitterApprovalCubit() : super(SitterApprovalInitial());

  Future<void> fetchSitterApprovals() async {
    emit(SitterApprovalLoading());

    try {
      final sitterList = await AdminProfileServices.getSitterApprovals(); // غيري الاسم حسب مكان الدالة
      emit(SitterApprovalSuccess(sitterList));
    } catch (e) {
      emit(SitterApprovalFailure(e.toString()));
    }
  }

Future<void> approveSitter(String userId) async {
  try {
    emit(SitterApprovalLoading());

    await AdminProfileServices.approve(userId);

    // بعد ما يوافق، نعيد تحميل القائمة
    final updatedList = await AdminProfileServices.getSitterApprovals();
    emit(SitterApprovalSuccess(updatedList));
  } catch (e) {
    emit(SitterApprovalFailure(e.toString()));
  }
}


}
