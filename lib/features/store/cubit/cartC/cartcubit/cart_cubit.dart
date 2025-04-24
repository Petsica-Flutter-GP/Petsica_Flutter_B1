// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:petsica/features/store/cubit/cartC/cartcubit/cart_state.dart';
// import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_state.dart';
// import 'package:petsica/features/store/services/cart_services.dart';

// class CartCubit extends Cubit<CartState> {
//   CartCubit() : super(CartInitial());

//   Future<void> fetchCartItems() async {
//     try {
//       emit(CartItemsLoading());
//       final cartItems = await CartService.getCartItems();
//       print('Fetched Cart Items: $cartItems');
//       emit(CartItemsLoaded(cartItems));  // تأكد من تحديث الحالة مع البيانات الجديدة
//     } catch (e) {
//       emit(CartItemsError(e.toString()));
//     }
//   }
// }
