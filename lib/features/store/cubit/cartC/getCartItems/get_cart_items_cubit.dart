import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_state.dart';
import 'package:petsica/features/store/models/cart_model.dart';
import 'package:petsica/features/store/services/cart_services.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  late CartResponseModel cartItems;

  Future<void> fetchCartItems() async {
    emit(CartItemsLoading());
    try {
      final cart = await CartService.getCartItems();
      cartItems = cart;
      emit(CartItemsLoaded(cartItems, cartItems.totalPrice,
          cartItems.totalQuantity)); // إصدار الحالة مع البيانات الكاملة
    } catch (e) {
      emit(CartItemsError(e.toString()));
    }
  }

  // دالة لتحديث الكمية في الواجهة مباشرة
  void updateCartItemInUI(int productId, int quantity) {
    final index =
        cartItems.items.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      // تحديث الكمية
      cartItems.items[index].updateQuantity(quantity);

      // حساب الإجمالي
      double totalPrice = 0.0;
      int totalQuantity = 0;

      for (var item in cartItems.items) {
        totalQuantity += item.quantity;
        totalPrice += (item.price - item.discount) * item.quantity;
      }

      // تحديث السلة بالقيم الجديدة
      final updatedCart = CartResponseModel(
        items: cartItems.items,
        totalQuantity: totalQuantity,
        totalPrice: totalPrice,
      );

      // إصدار الحالة مع البيانات المحدثة
      emit(CartItemsLoaded(updatedCart, totalPrice, totalQuantity));
    }
  }


  // ✅ حذف منتج من السلة وتحديث الواجهة
Future<void> deleteCartItemFromCart(int productId) async {
  try {
    await CartService.deleteCartItem(productId: productId);

    // حذف المنتج من القائمة داخل الموديل
    cartItems.items.removeWhere((item) => item.productId == productId);

    // إعادة حساب الكمية والسعر الإجمالي
    double totalPrice = 0.0;
    int totalQuantity = 0;

    for (var item in cartItems.items) {
      totalQuantity += item.quantity;
      totalPrice += (item.price - item.discount) * item.quantity;
    }

    // تحديث بيانات السلة
    final updatedCart = CartResponseModel(
      items: cartItems.items,
      totalQuantity: totalQuantity,
      totalPrice: totalPrice,
    );

    emit(CartItemsLoaded(updatedCart, totalPrice, totalQuantity));
  } catch (e) {
    emit(CartItemsError('فشل في حذف المنتج: $e'));
  }
}

  
}


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_state.dart';
// import 'package:petsica/features/store/models/cart_model.dart';
// import 'package:petsica/features/store/services/cart_services.dart';

// class CartCubit extends Cubit<CartState> {
//   CartCubit() : super(CartInitial());

//   late CartResponseModel cartItems;

//   // جلب العناصر من السلة
//   Future<void> fetchCartItems() async {
//     try {
//       emit(CartItemsLoading());
//       final cartItems = await CartService.getCartItems();
//       this.cartItems = cartItems;
//       emit(CartItemsLoaded(cartItems.items)); // تحميل العناصر
//     } catch (e) {
//       emit(CartItemsError(e.toString())); // في حالة حدوث خطأ
//     }
//   }

//   // دالة لتحديث الكمية في الواجهة مباشرة
//   void updateCartItemInUI(int productId, int quantity) {
//     final index =
//         cartItems.items.indexWhere((item) => item.productId == productId);
//     if (index != -1) {
//       // تحديث الكمية
//       cartItems.items[index].updateQuantity(quantity);
//       emit(CartItemsLoaded(cartItems.items)); // تحديث الواجهة بعد التعديل
//     }
//   }

//   // دالة لتحديث الكمية عن طريق API
//   Future<void> updateQuantity(int productId, int quantity) async {
//     try {
//       emit(CartItemsLoading());
//       // تحديث الكمية عبر الخدمة
//       final updatedCart = await CartService.updateCartItemQuantity(productId, quantity);
//       this.cartItems = updatedCart;
//       emit(CartItemsLoaded(updatedCart.items)); // تحديث العناصر في الواجهة
//     } catch (e) {
//       emit(CartItemsError(e.toString())); // في حالة حدوث خطأ
//     }
//   }
// }
