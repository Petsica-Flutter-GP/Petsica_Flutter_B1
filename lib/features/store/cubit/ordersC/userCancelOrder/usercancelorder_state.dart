import 'package:equatable/equatable.dart';

abstract class UserCancelOrderState extends Equatable {
  const UserCancelOrderState();

  @override
  List<Object?> get props => [];
}

class UserCancelOrderInitial extends UserCancelOrderState {}

class UserCancelOrderLoading extends UserCancelOrderState {}

class UserCancelOrderSuccess extends UserCancelOrderState {}

class UserCancelOrderFailure extends UserCancelOrderState {
  final String error;

  const UserCancelOrderFailure(this.error);

  @override
  List<Object?> get props => [error];
}
