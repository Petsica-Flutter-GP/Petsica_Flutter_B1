import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/clinicRequestDetails/clinic_request_details_state.dart';
import 'package:petsica/features/profiles/adminn/services/admin_profile_services.dart';


class ClinicDetailsCubit extends Cubit<ClinicDetailsState> {
  ClinicDetailsCubit() : super(ClinicDetailsInitial());

  Future<void> fetchClinicDetails(String userId) async {
    emit(ClinicDetailsLoading());
    try {
      final data = await AdminProfileServices.getClinicRequestDetails(userId);
      emit(ClinicDetailsLoaded(data));
    } catch (e) {
      emit(ClinicDetailsError(e.toString()));
    }
  }
}
