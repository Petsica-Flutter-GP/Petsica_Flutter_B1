import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/features/store/widgets/address_input_field.dart';
import 'package:shimmer/shimmer.dart'; // إضافة مكتبة Shimmer

import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_cubit.dart';
import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_state.dart';
import 'package:petsica/features/store/models/cart_model.dart';
import 'package:petsica/features/store/widgets/cart_item_card.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kStore),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).go(AppRouter.kCheckOut);
            },
            icon: const Icon(Icons.shopping_cart_checkout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartItemsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CartItemsLoading) {
              return ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Card(
                      color: kStoreContainerColor,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 120,
                                height: 120,
                                color: Colors.grey[300],
                              ),
                            ),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 24,
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    height: 20,
                                    width: 100,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    height: 20,
                                    width: 150,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        color: Colors.grey[300],
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        color: Colors.grey[300],
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is CartItemsLoaded) {
              final cart = state.cart;
              final cartItems = cart.items;

              if (cartItems.isEmpty) {
                // 🛒 حالة السلة الفارغة
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("🛒 No items in cart", style: Styles.textStyleCom18),
                      const SizedBox(height: 20),
                      Center(
                        child: AppButton(
                          text: 'Back to Store',
                          border: 9,
                          onTap: () {
                            GoRouter.of(context).go(AppRouter.kStore);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                // 🛍️ حالة السلة فيها منتجات
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Products: ${cart.totalQuantity}",
                                style: Styles.textStyleCom18),
                            Text(
                                "Total Price: ${cart.totalPrice.toStringAsFixed(2)}",
                                style: Styles.textStyleCom18),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          return CartItemCard(item: cartItems[index]);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: AppButton(
                          text: 'CheckOut',
                          border: 9,
                          onTap: () {
                            showDialogMessageCart(context);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
