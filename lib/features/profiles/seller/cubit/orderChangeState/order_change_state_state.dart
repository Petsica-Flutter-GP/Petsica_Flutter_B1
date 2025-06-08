import 'package:equatable/equatable.dart';

abstract class SellerOrderCompleteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SellerOrderCompleteInitial extends SellerOrderCompleteState {}

class SellerOrderCompleteLoading extends SellerOrderCompleteState {}

class SellerOrderCompleteSuccess extends SellerOrderCompleteState {}

class SellerOrderCompleteFailure extends SellerOrderCompleteState {
  final String error;

  SellerOrderCompleteFailure(this.error);

  @override
  List<Object?> get props => [error];
}
