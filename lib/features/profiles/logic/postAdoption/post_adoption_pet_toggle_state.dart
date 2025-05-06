abstract class PetToggleState {}

class PetToggleInitial extends PetToggleState {}

class PetToggleLoading extends PetToggleState {}

class PetToggleSuccess extends PetToggleState {}

class PetToggleFailure extends PetToggleState {
  final String error;
  PetToggleFailure(this.error);
}
