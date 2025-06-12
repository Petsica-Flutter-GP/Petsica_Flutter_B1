
abstract class AddSitterServiceState {}

class AddSitterServiceInitial extends AddSitterServiceState {}

class AddSitterServiceLoading extends AddSitterServiceState {}

class AddSitterServiceSuccess extends AddSitterServiceState {}

class AddSitterServiceFailure extends AddSitterServiceState {
  final String error;
  AddSitterServiceFailure(this.error);
}
