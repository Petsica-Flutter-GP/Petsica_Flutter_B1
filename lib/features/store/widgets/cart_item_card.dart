import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_cubit.dart';
import 'package:petsica/features/store/cubit/cartC/updateCart/update_cart_cubit.dart';
import 'package:petsica/features/store/cubit/cartC/updateCart/update_cart_state.dart';
import 'package:petsica/features/store/models/cart_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Uint8List imageBytes = base64Decode(item.photo);

    return Card(
      color: kStoreContainerColor,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: BlocBuilder<UpdateCartCubit, UpdateCartState>(
          builder: (context, state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.memory(imageBytes, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Tooltip(
                              message: item.productName,
                              child: Text(
                                item.productName,
                                style: Styles.textStyleCom22,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                              icon: const Icon(Icons.highlight_remove_outlined,
                                  color: kRemoveColor, size: 30),
                              onPressed: () async {
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AnimatedScale(
                                      scale: 1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        backgroundColor: Colors.white,
                                        title: const Text(
                                          'Are you sure?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text('Cancel',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16)),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 192, 39, 51),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text('Delete',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );

                                if (confirmed == true) {
                                  context
                                      .read<CartCubit>()
                                      .deleteCartItemFromCart(item.productId);
                                }
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${item.price.toStringAsFixed(2)} LE",
                            style: item.discount > 0
                                ? Styles.textStyleCom18.copyWith(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  )
                                : Styles.textStyleCom18
                                    .copyWith(color: kProducPriceColor),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "-${item.discount.toStringAsFixed(2)}",
                            style: Styles.textStyleCom18.copyWith(
                              color: item.discount > 0
                                  ? Colors.red
                                  : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Price : ${(item.price - item.discount).toStringAsFixed(2)} LE",
                        style: Styles.textStyleCom18
                            .copyWith(color: kProducPriceColor),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () async {
                              if (item.quantity > 1) {
                                await context
                                    .read<UpdateCartCubit>()
                                    .updateCartItem(
                                      productId: item.productId,
                                      quantity: item.quantity - 1,
                                    );
                                context.read<CartCubit>().updateCartItemInUI(
                                    item.productId, item.quantity - 1);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              side: const BorderSide(
                                  color: kBurgColor, width: 1.5),
                              padding: const EdgeInsets.all(4),
                              minimumSize: const Size(30, 30),
                            ),
                            child: const Icon(Icons.remove,
                                color: kBurgColor, size: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "${item.quantity}",
                              style: Styles.textStyleCom18,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await context
                                  .read<UpdateCartCubit>()
                                  .updateCartItem(
                                    productId: item.productId,
                                    quantity: item.quantity + 1,
                                  );
                              context.read<CartCubit>().updateCartItemInUI(
                                  item.productId, item.quantity + 1);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: kBurgColor,
                              padding: const EdgeInsets.all(6),
                              minimumSize: const Size(30, 30),
                            ),
                            child: const Icon(Icons.add,
                                color: Colors.white, size: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
