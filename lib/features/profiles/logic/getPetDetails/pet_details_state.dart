part of 'pet_details_cubit.dart';

abstract class PetDetailsState {}

class PetDetailsInitial extends PetDetailsState {}

class PetDetailsLoading extends PetDetailsState {}

class PetDetailsLoaded extends PetDetailsState {
  final GetPetModel pet;

  PetDetailsLoaded(this.pet);
}

class PetDetailsError extends PetDetailsState {
  final String error;

  PetDetailsError(this.error);
}
