// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_cubit.dart';
// import 'package:petsica/features/store/cubit/cartC/updateCart/update_cart_state.dart';
// import 'package:petsica/features/store/services/cart_services.dart';

// class UpdateCartCubit extends Cubit<UpdateCartState> {
//   final CartService cartService;
//   final CartCubit cartCubit; // مهم علشان نقدر نعيد تحميل البيانات

//   UpdateCartCubit(this.cartService, this.cartCubit)
//       : super(UpdateCartInitial());

//   Future<void> updateCartItem({
//     required int productId,
//     required int quantity,
//   }) async {
//     emit(UpdateCartLoading());
//     try {
//       await CartService.updateCartItem(productId: productId, quantity: quantity);
//       emit(UpdateCartSuccess());

//       // ✅ بعد التحديث الناجح: نعيد تحميل السلة
//       await cartCubit.fetchCartItems();
//     } catch (e) {
//       emit(UpdateCartFailure(e.toString()));
//     }
//   }

// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_cubit.dart';
import 'package:petsica/features/store/cubit/cartC/updateCart/update_cart_state.dart';
import 'package:petsica/features/store/services/cart_services.dart';

class UpdateCartCubit extends Cubit<UpdateCartState> {
  final CartService cartService;
  final CartCubit cartCubit;

  UpdateCartCubit({
    required this.cartService,
    required this.cartCubit,
  }) : super(UpdateCartInitial());

  Future<void> updateCartItem({
    required int productId,
    required int quantity,
  }) async {
    try {
      await CartService.updateCartItem(
          productId: productId, quantity: quantity);

      emit(UpdateCartSuccess());
    } catch (e) {
      emit(UpdateCartFailure(e.toString()));
    }
  }
}
