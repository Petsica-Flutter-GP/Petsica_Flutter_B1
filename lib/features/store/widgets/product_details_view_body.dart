import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/features/store/cubit/getbyid/get_by_id_cubit.dart';
import 'package:petsica/features/store/cubit/getbyid/get_by_id_state.dart';
import '../../../core/constants.dart';
import '../../../core/utils/asset_data.dart';
import '../../../core/utils/app_arrow_back.dart';
import '../../../core/utils/styles.dart';

class ProductDetailsViewBody extends StatelessWidget {
  const ProductDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.7;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: Styles.textStyleQu28,
        ),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kStore),
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailsFailure) {
            return Center(child: Text(state.error));
          }

          if (state is ProductDetailsSuccess) {
            final product = state.product;

            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 23, horizontal: 23),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
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
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                base64Decode(product.photo),
                                width: 300,
                                height: 240,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.productName,
                                    style: Styles.textStyleCom28
                                        .copyWith(color: kProductTxtColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "\$${product.price}",
                                        style: Styles.textStyleCom24
                                            .copyWith(color: kProducPriceColor),
                                      ),
                                      Text(
                                        "-%${product.discount}",
                                        style: Styles.textStyleCom22
                                            .copyWith(color: kRemoveColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 20),
                              // Text(
                              //   "Sold by: ${product.sellerId}",
                              //   style: Styles.textStyleCom22
                              //       .copyWith(color: kProductTxtColor),
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              // ),
                              const SizedBox(height: 12),
                              Text(
                                product.description,
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
                              GoRouter.of(context).go(AppRouter.kStore);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Added successfully!"),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
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
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
