import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/store/widgets/image_box.dart';

import '../../../core/constants.dart';
import '../../../core/utils/asset_data.dart';

class ProductCard extends StatelessWidget {
  final String productName;

  const ProductCard({super.key, required this.productName});

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
            const ImageBox(imagePath: AssetData.productImage),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      productName,
                      style: Styles.textStyleCom18
                          .copyWith(color: kProductTxtColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Sold by ..",
                      style: Styles.textStyleCom16
                          .copyWith(color: kProductTxtColor),
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
                    const SizedBox(
                      height: 5,
                    ),
                    Text("\$100",
                        style: Styles.textStyleQui18
                            .copyWith(color: kProducPriceColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
