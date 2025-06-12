// profile_state.dart

part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserProfileModel profile;
  ProfileSuccess(this.profile);
}

class ProfileFailure extends ProfileState {
  final String error;
  ProfileFailure(this.error);
}
