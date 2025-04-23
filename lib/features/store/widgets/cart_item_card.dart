import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/store/cubit/cartC/getCartItems/get_cart_items_cubit.dart';
import 'package:petsica/features/store/logic/cubit/cart_cubit.dart';
import 'package:petsica/features/store/models/cart_model.dart';
import 'package:petsica/features/store/widgets/image_box.dart';
import 'package:petsica/features/store/widgets/product_deletion_show_dialog.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    Uint8List imageBytes = base64Decode(item.photo);

    return Card(
      color: kStoreContainerColor,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ صورة المنتج ✅
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.memory(
                  imageBytes,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            const SizedBox(width: 13),

            // ✅ التفاصيل ✅
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
                      IconButton(
                        icon: const Icon(Icons.highlight_remove_outlined,
                            color: kRemoveColor, size: 30),
                        onPressed: () {
                          // ProductDeletionShowDialog(context, () {
                          //   cubit.removeItem(item.productId);
                          // });
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ لو في خصم > 0
                      if (item.discount > 0) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // السعر الأصلي مشطوب
                            Text(
                              "${item.price.toStringAsFixed(2)} LE",
                              style: Styles.textStyleCom18.copyWith(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 30),
                            // التخفيض باللون الأحمر
                            Text(
                              "-${item.discount.toStringAsFixed(2)}",
                              style: Styles.textStyleCom18
                                  .copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // السعر بعد الخصم
                        Text(
                          "Price : ${(item.price - item.discount).toStringAsFixed(2)} LE",
                          style: Styles.textStyleCom18
                              .copyWith(color: kProducPriceColor),
                        ),
                      ] else ...[
                        // ✅ لو الخصم = 0
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${item.price.toStringAsFixed(2)} LE",
                              style: Styles.textStyleCom18
                                  .copyWith(color: kProducPriceColor),
                            ),
                            const SizedBox(width: 30),
                            Text(
                              "-${item.discount.toStringAsFixed(2)}",
                              style: Styles.textStyleCom18
                                  .copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Price : ${item.price.toStringAsFixed(2)} LE",
                          style: Styles.textStyleCom18
                              .copyWith(color: kProducPriceColor),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 15),

                  // ✅ كمية + - ✅
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        // item.quantity > 1
                        // ? () => cubit.updateQuantity(item.productId, item.quantity - 1)
                        // : null,
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          side: const BorderSide(color: kBurgColor, width: 1.5),
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
                        onPressed: () {},
                        // () => cubit.updateQuantity(item.productId, item.quantity + 1),
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
        ),
      ),
    );
  }
}
