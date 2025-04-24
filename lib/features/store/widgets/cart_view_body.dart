import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_cubit.dart';
import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_state.dart';
import 'package:petsica/features/store/logic/cubit/cart_cubit.dart';
import 'package:petsica/features/store/widgets/cart_item_card.dart';
import 'package:petsica/features/store/widgets/confirm_address_show_dialog.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().fetchCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kStore),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartItemsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartItemsError) {
              return Center(child: Text("❌ ${state.errorMessage}"));
            } else if (state is CartItemsLoaded) {
  final cart = (state as CartItemsLoaded).cart;
  final cartItems = cart.items;

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Products: ${cart.totalQuantity}", style: Styles.textStyleCom18),
            Text("Total Price: ${cart.totalPrice.toStringAsFixed(2)}", style: Styles.textStyleCom18),
          ],
                    ),
                  ),
                  Expanded(
                    child: cartItems.isEmpty
                        ? const Center(child: Text("🛒 No items in cart"))
                        : ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              return CartItemCard(item: cartItems[index]);
                            },
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AppButton(
                      text: cartItems.isEmpty ? 'Back to Store' : 'CheckOut',
                      border: 9,
                      onTap: () {
                        if (cartItems.isEmpty) {
                          GoRouter.of(context).go(AppRouter.kStore);
                        } else {
                          showDialogMessageCart(context);
                        }
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
