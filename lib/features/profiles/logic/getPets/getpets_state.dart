import 'package:petsica/features/profiles/model/get_pet_model.dart';

abstract class PetState {}

class PetInitial extends PetState {}

class PetLoading extends PetState {}

class PetLoaded extends PetState {
  final List<GetPetModel> pets; // هنا تأكد من استخدام GetPetModel

  PetLoaded({required this.pets});
}

class PetError extends PetState {
  final String errorMessage;

  PetError({required this.errorMessage});
}
