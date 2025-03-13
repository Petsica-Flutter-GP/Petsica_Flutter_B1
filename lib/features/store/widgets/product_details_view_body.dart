import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/features/store/widgets/product_card.dart';
import '../../../core/constants.dart';
import '../../../core/utils/asset_data.dart';
import '../../../core/utils/store_arrow_back.dart';
import '../../../core/utils/styles.dart';

class ProductDetailsViewBody extends StatelessWidget {
  const ProductDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight =
        MediaQuery.of(context).size.height; // ✅ جلب ارتفاع الشاشة ✅
    double containerHeight =
        screenHeight * 0.7; // ✅ ضبط ارتفاع الكونتينر ليكون 70% من الشاشة ✅

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: Styles.textStyleQu28,
        ),
        centerTitle: true,
        leading: const StoreArrowBack(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 23),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: kStoreContainerColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: const Offset(0, 4),
                      blurRadius: 3.5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        // border: Border.all(
                        //   color: Colors.grey,
                        //   width: 2,
                        // ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          AssetData.productImage,
                          width: 300,
                          height: 240,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product Name',
                              style: Styles.textStyleCom28
                                  .copyWith(color: kProductTxtColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "\$500",
                              style: Styles.textStyleCom24
                                  .copyWith(color: kProducPriceColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Sold by ..",
                          style: Styles.textStyleCom22
                              .copyWith(color: kProductTxtColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Product Details Product Details Product Details Product Details Product Details Product Details",
                          style: Styles.textStyleCom22.copyWith(
                              color: kProductTxtColor.withOpacity(0.6)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    AppButton(
                      text: 'Add To Cart',
                      border: 10,
                      onTap: () {
                         GoRouter.of(context).go(
                  AppRouter.kCheckOut,
                  
                );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
