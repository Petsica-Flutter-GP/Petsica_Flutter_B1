import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_cubit.dart';
import 'package:petsica/features/store/cubit/cartC/updateCart/update_cart_cubit.dart';
import 'package:petsica/features/store/services/cart_services.dart';
import 'package:petsica/features/store/widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cartCubit = CartCubit()..fetchCartItems();
        return cartCubit;
      },
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (_) => UpdateCartCubit(
              cartService: CartService(),
              cartCubit: context.read<CartCubit>(),
            ),
            child: const CartViewBody(),
          );
        },
      ),
    );
  }
}
