import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/services/cart_services.dart';

// الحالة الأساسية
abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {}

class AddToCartSuccess extends AddToCartState {}

class AddToCartFailure extends AddToCartState {
  final String error;

  AddToCartFailure(this.error);
}