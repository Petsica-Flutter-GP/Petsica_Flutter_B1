// abstract class PetToggleState {}

// class PetToggleInitial extends PetToggleState {}

// class PetToggleLoading extends PetToggleState {}

// class PetToggleSuccess extends PetToggleState {}

// class PetToggleFailure extends PetToggleState {
//   final String error;
//   PetToggleFailure(this.error);
// }
abstract class PetToggleState {}

class PetToggleInitial extends PetToggleState {}

class PetToggleLoading extends PetToggleState {}

class PetToggleSuccess extends PetToggleState {
  final String message;
  PetToggleSuccess({required this.message});
}

class PetToggleFailure extends PetToggleState {
  final String errorMessage;
  PetToggleFailure({required this.errorMessage});
}