
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminAcceptRequest/accept_request_state.dart';
import 'package:petsica/features/profiles/adminn/services/admin_profile_services.dart';


class ApprovalCubit extends Cubit<ApprovalState> {
  ApprovalCubit() : super(ApprovalInitial());

  Future<void> approveUser(String userId) async {
    emit(ApprovalLoading());
    try {
      await AdminProfileServices.approve(userId);
      emit(ApprovalSuccess());
    } catch (e) {
      emit(ApprovalError(e.toString()));
    }
  }
}
