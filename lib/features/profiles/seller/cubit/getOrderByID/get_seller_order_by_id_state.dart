import 'package:equatable/equatable.dart';
import 'package:petsica/features/profiles/seller/models/seller_orders_model.dart';

abstract class GetSellerOrderByIdState extends Equatable {
  const GetSellerOrderByIdState();

  @override
  List<Object?> get props => [];
}

class GetSellerOrderByIdInitial extends GetSellerOrderByIdState {}

class GetSellerOrderByIdLoading extends GetSellerOrderByIdState {}

class GetSellerOrderByIdLoaded extends GetSellerOrderByIdState {
  final SellerOrderByIdModel order;

  const GetSellerOrderByIdLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

class GetSellerOrderByIdError extends GetSellerOrderByIdState {
  final String message;

  const GetSellerOrderByIdError(this.message);

  @override
  List<Object?> get props => [message];
}
