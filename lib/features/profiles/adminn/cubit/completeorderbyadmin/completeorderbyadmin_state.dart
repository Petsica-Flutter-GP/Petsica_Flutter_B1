abstract class CompleteOrderState {}

class CompleteOrderInitial extends CompleteOrderState {}

class CompleteOrderLoading extends CompleteOrderState {}

class CompleteOrderSuccess extends CompleteOrderState {}

class CompleteOrderErrorState extends CompleteOrderState {
  final String message;
  CompleteOrderErrorState(this.message);
}
