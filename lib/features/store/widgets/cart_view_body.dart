import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/store_arrow_back.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/store/logic/cubit/cart_cubit.dart';
import 'package:petsica/features/store/widgets/confirm_address_show_dialog.dart';

import '../../../core/utils/app_router.dart';
import 'cart_item_card.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart", style: Styles.textStyleQu28),
          centerTitle: true,
          leading: const StoreArrowBack(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: BlocBuilder<CartCubit, List<Map<String, dynamic>>>(
                  builder: (context, cartItems) {
                    final cubit = context.read<CartCubit>();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${cubit.getTotalItems()} Products",
                            style: Styles.textStyleCom18),
                        Text(
                            "Total Price: \$${cubit.getTotalPrice().toStringAsFixed(2)}",
                            style: Styles.textStyleCom18),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<CartCubit, List<Map<String, dynamic>>>(
                  builder: (context, cartItems) {
                    return cartItems.isEmpty
                        ? const Center(
                            child: Text("No items",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey)))
                        : ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return CartItemCard(
                                item: item,
                                onDelete: () {
                                  context.read<CartCubit>().removeItem(index);
                                },
                                onQuantityChanged: (newQuantity) {
                                  context
                                      .read<CartCubit>()
                                      .updateItemQuantity(index, newQuantity);
                                },
                              );
                            },
                          );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: BlocBuilder<CartCubit, List<Map<String, dynamic>>>(
                  builder: (context, cartItems) {
                    return AppButton(
                      text: cartItems.isEmpty ? 'Back to Store' : 'CheckOut',
                      border: 9,
                      onTap: () {
                        if (cartItems.isEmpty) {
                          GoRouter.of(context).go(
                            AppRouter.kStore,
                          );
                        } else {
                          showDialogMessage(context);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
