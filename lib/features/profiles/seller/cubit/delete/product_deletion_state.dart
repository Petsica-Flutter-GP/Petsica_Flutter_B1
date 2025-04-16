
part of 'product_deletion_cubit.dart';

abstract class ProductDeletionState {}

class ProductDeletionInitial extends ProductDeletionState {}

class ProductDeletionLoading extends ProductDeletionState {}

class ProductDeletionSuccess extends ProductDeletionState {}

class ProductDeletionFailure extends ProductDeletionState {
  final String error;
  ProductDeletionFailure(this.error);
}
