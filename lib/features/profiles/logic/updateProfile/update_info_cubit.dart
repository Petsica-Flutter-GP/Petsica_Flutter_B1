
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/logic/updateProfile/update_info_state.dart';
import 'package:petsica/features/profiles/services/profile_services.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  Future<void> updateProfile({
    required String userName,
    required String photo,
    required String address,
    required String location,
  }) async {
    emit(UpdateProfileLoading());
    try {
      await UserService.updateUserProfile(
        userName: userName,
        photo: photo,
        address: address,
        location: location,
      );
      emit(UpdateProfileSuccess());
    } catch (e) {
      emit(UpdateProfileFailure(e.toString()));
    }
  }
}
