import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/features/store/widgets/image_box.dart';
import 'package:petsica/features/store/widgets/product_deletion_show_dialog.dart';

import '../../../core/utils/styles.dart';

class CartItemCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback onDelete;

  const CartItemCard({super.key, required this.item, required this.onDelete});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const SizedBox(
                      width: 120,
                      height: 120,
                      child: ImageBox(imagePath: AssetData.productImage)),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.item["name"], style: Styles.textStyleCom22),
                      Text("\$${widget.item["price"]}",
                          style: Styles.textStyleCom18
                              .copyWith(color: kProducPriceColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // زر الحذف في الزاوية العلوية اليمنى
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.highlight_remove_outlined,
                  color: kRemoveColor, size: 30),
              onPressed: () {
                _showDeleteDialog(context);
              },
            ),
          ),
          // أزرار التحكم في الكمية
          Positioned(
            bottom: 10,
            right: 0,
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      if (widget.item["quantity"] > 1) {
                        widget.item["quantity"]--;
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(color: kBurgColor, width: 1.5),
                    padding: const EdgeInsets.all(4),
                    minimumSize: const Size(28, 28),
                  ),
                  child: const Icon(Icons.remove, color: kBurgColor, size: 18),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.item["quantity"].toString().padLeft(2, '0'),
                    style: Styles.textStyleCom18,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.item["quantity"]++;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: kBurgColor,
                    padding: const EdgeInsets.all(6),
                    minimumSize: const Size(26, 26),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    ProductDeletionShowDialog(context, widget.onDelete);
  }
}
