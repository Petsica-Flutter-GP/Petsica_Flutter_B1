import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/services/cart_services.dart';
import 'package:petsica/features/store/cubit/cartC/add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());

  Future<void> addToCart({
    required int productId,
    required int quantity,
  }) async {
    emit(AddToCartLoading());
    try {
      await CartService.addToCart(
        productId: productId,
        quantity: quantity,
      );
      emit(AddToCartSuccess());
    } catch (e) {
      emit(AddToCartFailure("فشل في الإضافة: $e"));
    }
  }
}
