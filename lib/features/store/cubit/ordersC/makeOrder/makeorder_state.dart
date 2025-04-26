abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {}

class OrderError extends OrderState {
  final String errorMessage;
  OrderError(this.errorMessage);
}
