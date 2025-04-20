import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';

// تعريف الحالات المختلفة لـ Cubit
abstract class GetByCategoryState extends Equatable {
  const GetByCategoryState();

  @override
  List<Object?> get props => [];
}

class GetByCategoryInitial extends GetByCategoryState {}

class GetByCategoryLoading extends GetByCategoryState {}

class GetByCategoryLoaded extends GetByCategoryState {
  final List<Product> products;

  const GetByCategoryLoaded(this.products);

  @override
  List<Object?> get props => [products];
}


class GetByCategoryError extends GetByCategoryState {
  final String message;

  const GetByCategoryError(this.message);

  @override
  List<Object?> get props => [message];
}