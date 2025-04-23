
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_state.dart';
import 'package:petsica/features/store/services/cart_services.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> fetchCartItems() async {
    emit(CartLoading());
    try {
      final data = await CartService.getCartItems();
      emit(CartLoaded(data));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
