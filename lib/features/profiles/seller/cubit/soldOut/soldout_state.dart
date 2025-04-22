class SoldOutState {}

class SoldOutInitial extends SoldOutState {}

class SoldOutLoading extends SoldOutState {}

class SoldOutSuccess extends SoldOutState {
  final int productId;

  SoldOutSuccess({required this.productId});
}

class SoldOutError extends SoldOutState {
  final String message;

  SoldOutError({required this.message});
}