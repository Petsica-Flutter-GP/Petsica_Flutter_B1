import 'package:equatable/equatable.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];
}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final Product product;

  const ProductDetailsSuccess(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductDetailsFailure extends ProductDetailsState {
  final String error;

  const ProductDetailsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
