// profile_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/services/profile_services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await UserService.getUserProfile();
      emit(ProfileSuccess(profile));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
