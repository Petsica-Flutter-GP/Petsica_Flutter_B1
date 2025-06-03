abstract class AddPetState {}

class AddPetInitial extends AddPetState {}

class AddPetLoading extends AddPetState {}

class AddPetSuccess extends AddPetState {}

class AddPetFailure extends AddPetState {
  final String error;
  AddPetFailure(this.error);
}
