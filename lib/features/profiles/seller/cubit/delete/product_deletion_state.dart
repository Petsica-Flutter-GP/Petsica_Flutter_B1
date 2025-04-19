part of 'product_deletion_cubit.dart';

@immutable
abstract class ProductDeletionState {}

class ProductDeletionInitial extends ProductDeletionState {}

class ProductDeletionLoading extends ProductDeletionState {}

class ProductDeletionSuccess extends ProductDeletionState {}

class ProductDeletionFailure extends ProductDeletionState {
  final String message;

  ProductDeletionFailure({required this.message});
}
