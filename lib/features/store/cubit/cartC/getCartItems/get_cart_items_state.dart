import 'package:petsica/features/store/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartItemsLoading extends CartState {}

class CartItemsLoaded extends CartState {
  final CartResponseModel cart;
  final double totalPrice;
  final int totalQuantity;


  CartItemsLoaded(this.cart, this.totalPrice, this.totalQuantity);
}




class CartItemsError extends CartState {
  final String errorMessage;
  CartItemsError(this.errorMessage);
}
