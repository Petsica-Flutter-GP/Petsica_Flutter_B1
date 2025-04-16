import 'package:equatable/equatable.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';

abstract class SellerProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SellerProductsInitial extends SellerProductsState {}

class SellerProductsLoading extends SellerProductsState {}

class SellerProductsLoaded extends SellerProductsState {
  final List<Product> products;

  SellerProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class SellerProductsError extends SellerProductsState {
  final String message;

  SellerProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
