import 'package:petsica/features/store/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartItemsLoading extends CartState {}

class CartItemsLoaded extends CartState {
  final CartResponseModel cart;

  CartItemsLoaded(this.cart);
}




class CartItemsError extends CartState {
  final String errorMessage;
  CartItemsError(this.errorMessage);
}
