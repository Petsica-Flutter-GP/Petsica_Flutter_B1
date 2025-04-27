import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/models/user_order_model.dart';

// States
abstract class UserOrderDetailsState {}

class UserOrderDetailsInitial extends UserOrderDetailsState {}

class UserOrderDetailsLoading extends UserOrderDetailsState {}

class UserOrderDetailsLoaded extends UserOrderDetailsState {
  final UserOrderModel order;

  UserOrderDetailsLoaded(this.order);
}

class UserOrderDetailsError extends UserOrderDetailsState {
  final String errorMessage;

  UserOrderDetailsError(this.errorMessage);
}