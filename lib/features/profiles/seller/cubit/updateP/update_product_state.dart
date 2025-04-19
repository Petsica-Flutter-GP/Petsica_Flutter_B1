import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// تعريف حالات الـ Cubit
abstract class UpdateProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateProductInitial extends UpdateProductState {}

class UpdateProductLoading extends UpdateProductState {}

class UpdateProductSuccess extends UpdateProductState {}

class UpdateProductFailure extends UpdateProductState {
  final String error;

  UpdateProductFailure(this.error);

  @override
  List<Object> get props => [error];
}
