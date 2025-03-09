import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petsica/core/utils/styles.dart';

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
            Expanded(
              child: Center(
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage(AssetData.productImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text(
                    "Product Details",
                    style:
                        Styles.textStyleCom16.copyWith(color: kProductTxtColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$100",
                    style: Styles.textStyleCom16
                        .copyWith(color: kProducPriceColor),
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
