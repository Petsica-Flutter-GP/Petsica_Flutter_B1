import 'package:equatable/equatable.dart';
import 'package:petsica/features/store/models/user_order_model.dart';

abstract class UserOrderState extends Equatable {
  const UserOrderState();

  @override
  List<Object> get props => [];
}

class UserOrderInitial extends UserOrderState {}

class UserOrderLoading extends UserOrderState {}

class UserOrderLoaded extends UserOrderState {
  final List<UserOrderModel> orders;

  const UserOrderLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class UserOrderError extends UserOrderState {
  final String errorMessage;

  const UserOrderError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
