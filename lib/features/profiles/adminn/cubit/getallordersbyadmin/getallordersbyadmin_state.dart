import 'package:equatable/equatable.dart';


abstract class AdminOrdersState extends Equatable {
  const AdminOrdersState();

  @override
  List<Object> get props => [];
}

class AdminOrdersInitial extends AdminOrdersState {}

class AdminOrdersLoading extends AdminOrdersState {}

class AdminOrdersLoaded extends AdminOrdersState {
  final List<dynamic> orders;

  const AdminOrdersLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class AdminOrdersError extends AdminOrdersState {
  final String message;

  const AdminOrdersError({required this.message});

  @override
  List<Object> get props => [message];
}
