abstract class MakeOrderState {}

class MakeOrderInitial extends MakeOrderState {}

class MakeOrderLoading extends MakeOrderState {}

class MakeOrderSuccess extends MakeOrderState {}

class MakeOrderError extends MakeOrderState {
  final String errorMessage;
  MakeOrderError(this.errorMessage);
}
