import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/features/store/widgets/image_box.dart';
import 'package:petsica/features/store/widgets/product_deletion_show_dialog.dart';

import '../../../core/utils/styles.dart';

class CartItemCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback onDelete;
  final VoidCallback onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onQuantityChanged,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
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
              child: const SizedBox(
                width: 120,
                height: 120,
                child: ImageBox(imagePath: AssetData.productImage),
              ),
            ),
            const SizedBox(width: 13),

            // ✅ اسم المنتج، السعر، وزر الحذف ✅
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // ✅ اسم المنتج مع Tooltip ✅
                      Expanded(
                        child: Tooltip(
                          message: widget.item["name"],
                          child: Text(
                            widget.item["name"],
                            style: Styles.textStyleCom22,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // ✅ زر الحذف ✅
                      IconButton(
                        icon: const Icon(Icons.highlight_remove_outlined,
                            color: kRemoveColor, size: 30),
                        onPressed: () {
                          _showDeleteDialog(context);
                        },
                      ),
                    ],
                  ),

                  // ✅ السعر الأساسي للمنتج ✅
                  Text(
                    "Unit Price: \$${widget.item["price"]}",
                    style: Styles.textStyleCom18
                        .copyWith(color: kProducPriceColor),
                  ),

                  const SizedBox(height: 15),

                  // ✅ أزرار التحكم في الكمية ✅
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // زر إنقاص الكمية
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            if (widget.item["quantity"] > 1) {
                              widget.item["quantity"]--;
                              widget.onQuantityChanged(); // تحديث السعر الكلي
                            }
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          side: const BorderSide(color: kBurgColor, width: 1.5),
                          padding: const EdgeInsets.all(4),
                          minimumSize: const Size(35, 35),
                        ),
                        child: const Icon(Icons.remove,
                            color: kBurgColor, size: 18),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          widget.item["quantity"].toString().padLeft(2, '0'),
                          style: Styles.textStyleCom18,
                        ),
                      ),

                      // زر زيادة الكمية
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.item["quantity"]++;
                            widget.onQuantityChanged(); // تحديث السعر الكلي
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: kBurgColor,
                          padding: const EdgeInsets.all(6),
                          minimumSize: const Size(35, 35),
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

  void _showDeleteDialog(BuildContext context) {
    ProductDeletionShowDialog(context, widget.onDelete);
  }
}
