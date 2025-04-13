import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/widget/seller_product_deletion_show_dialog.dart';
import 'package:petsica/features/store/widgets/image_box.dart';

import '../../../store/logic/cubit/cart_cubit.dart';

class SellerProductCard extends StatelessWidget {
  final String productName;
  final VoidCallback onDelete; // الدالة التي ستتم إضافتها لحذف العنصر

  const SellerProductCard({
    super.key,
    required this.productName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kStoreContainerColor, // يمكنك تغييره لأي لون آخر
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // شفافية الظل
            offset: const Offset(0, 4), // الظل فقط لأسفل
            blurRadius: 3.5, // نعومة الظل
            spreadRadius: 0, // منع انتشار الظل
          ),
        ],
        borderRadius: BorderRadius.circular(10), // الحفاظ على الزوايا الدائرية
      ),
      child: Card(
        color: kStoreContainerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0, // تعطيل ظل الكارد الافتراضي لمنع التكرار
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const ImageBox(imagePath: AssetData.productImage),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      _showDeleteDialog(context); // استدعاء دالة الحذف
                      print("Item Deleted");
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    productName,
                    style:
                        Styles.textStyleCom18.copyWith(color: kProductTxtColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Sold by ..",
                    style:
                        Styles.textStyleCom16.copyWith(color: kProductTxtColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Tooltip(
                    message:
                        "Product Details Product Details Product Details Product Details",
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(color: Colors.white),
                    child: Text(
                      "Product Details...",
                      style: Styles.textStyleCom16
                          .copyWith(color: kProductTxtColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // السعر
                      Text(
                        "\$100",
                        style: Styles.textStyleQui18
                            .copyWith(color: kProducPriceColor),
                      ),
                      // أيقونة التعديل بجانب السعر
                      GestureDetector(
                        onTap: () {
                          // يمكنك إضافة وظيفة التعديل هنا
                          print("Edit Item");
                        },
                        child: InkWell(
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 23,
                          ),
                          onTap: () {
                            GoRouter.of(context)
                                .go(AppRouter.kSellerEditProduct);
                          },
                        ),
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

  // دالة عرض نافذة الحذف
  void _showDeleteDialog(BuildContext context) {
    SellerProductDeletionShowDialog(context, onDelete); // تمرير onDelete مباشرة
  }
}
