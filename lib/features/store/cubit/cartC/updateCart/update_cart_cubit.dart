// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_cubit.dart';
// import 'package:petsica/features/store/cubit/cartC/updateCart/update_cart_state.dart';
// import 'package:petsica/features/store/services/cart_services.dart';

// class UpdateCartCubit extends Cubit<UpdateCartState> {
//   final CartService cartService;
//   final CartCubit cartCubit;

//   UpdateCartCubit({
//     required this.cartService,
//     required this.cartCubit,
//   }) : super(UpdateCartInitial());

//   Future<void> updateCartItem({
//     required int productId,
//     required int quantity,
//   }) async {
//     emit(UpdateCartLoading());
//     try {
//       await CartService.updateCartItem(
//         productId: productId,
//         quantity: quantity,
//       );

//       emit(UpdateCartSuccess());
//     } catch (e) {
//       emit(UpdateCartFailure(e.toString()));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart'; // تأكد من استيراد مكتبة الـ Snackbar
import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_cubit.dart';
import 'package:petsica/features/store/cubit/cartC/updateCart/update_cart_state.dart';
import 'package:petsica/features/store/services/cart_services.dart';

class UpdateCartCubit extends Cubit<UpdateCartState> {
  final CartService cartService;
  final CartCubit cartCubit;
  final BuildContext context; // إضافة Context لعرض SnackBar

  UpdateCartCubit({
    required this.cartService,
    required this.cartCubit,
    required this.context, // تمرير Context للمحول
  }) : super(UpdateCartInitial());

  // Future<void> updateCartItem({
  //   required int productId,
  //   required int quantity,
  // }) async {
  //   emit(UpdateCartLoading());

  //   try {
  //     final response = await CartService.updateCartItem(
  //       productId: productId,
  //       quantity: quantity,
  //     );

  //     // التحقق من الاستجابة
  //     if (response.statusCode == 204) {
  //       emit(UpdateCartSuccess());
  //       print("تم تحديث الكمية بنجاح للمنتج: $productId، الكمية: $quantity");
  //     } else {
  //       emit(UpdateCartFailure("فشل التحديث: ${response.statusCode}"));
  //       // عرض الخطأ باستخدام SnackBar
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('فشل التحديث: ${response.statusCode}'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     emit(UpdateCartFailure(e.toString()));
  //     // عرض الخطأ باستخدام SnackBar
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.toString()),  // عرض رسالة الخطأ
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     print("حدث خطأ أثناء التحديث: $e");
  //   }
  // }

  Future<void> updateCartItem({
    required int productId,
    required int quantity,
  }) async {
    emit(UpdateCartLoading());
    try {
      final response = await CartService.updateCartItem(
        productId: productId,
        quantity: quantity,
      );

      if (response.statusCode == 200) {
        emit(UpdateCartSuccess());
      } else {
        emit(UpdateCartFailure("فشل التحديث: ${response.statusCode}"));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل التحديث: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      emit(UpdateCartFailure(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
