import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/features/store/cubit/cartC/addToCart/add_to_cart_cubit.dart';
import 'package:petsica/features/store/cubit/cartC/addToCart/add_to_cart_state.dart';
import 'package:petsica/features/store/cubit/storeC/getbyid/get_by_id_cubit.dart';
import 'package:petsica/features/store/cubit/storeC/getbyid/get_by_id_state.dart';
import '../../../core/constants.dart';
import '../../../core/utils/app_arrow_back.dart';
import '../../../core/utils/styles.dart';

class ProductDetailsViewBody extends StatefulWidget {
  const ProductDetailsViewBody({super.key});

  @override
  State<ProductDetailsViewBody> createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddToCartCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details", style: Styles.textStyleQu28),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// 🟡 اسم المنتج
                                      Text(
                                        product.productName,
                                        style: Styles.textStyleCom28
                                            .copyWith(color: kProductTxtColor),
                                      ),

                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\$${product.price}  ",
                                                style: Styles.textStyleCom24
                                                    .copyWith(
                                                  color: kProducPriceColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "-%${product.discount}",
                                                style: Styles.textStyleCom22
                                                    .copyWith(
                                                  color: kRemoveColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    product.category,
                                    style: Styles.textStyleCom22.copyWith(
                                        color:
                                            kProductTxtColor.withOpacity(0.6)),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    product.description,
                                    style: Styles.textStyleCom22.copyWith(
                                      color: kProductTxtColor.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),

                            /// ✅ زر الإضافة إلى السلة
                            product.isAvailable
                                ? BlocConsumer<AddToCartCubit, AddToCartState>(
                                    listener: (context, state) {
                                      if (state is AddToCartSuccess) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text("✅ Added Succesfully"),
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 1),
                                          ),
                                        );

                                        Future.delayed(
                                            const Duration(milliseconds: 100),
                                            () {
                                          GoRouter.of(context)
                                              .go(AppRouter.kStore);
                                        });
                                      } else if (state is AddToCartFailure) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text("❌ Error: ${state.error}"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      return AnimatedBuilder(
                                        animation: _animation,
                                        builder: (context, child) {
                                          return Transform.translate(
                                            offset:
                                                Offset(0, -_animation.value),
                                            child: AppButton(
                                              text: state is AddToCartLoading
                                                  ? 'Loading..'
                                                  : 'Add To Cart',
                                              border: 10,
                                              onTap: state is AddToCartLoading
                                                  ? null
                                                  : () {
                                                      context
                                                          .read<
                                                              AddToCartCubit>()
                                                          .addToCart(
                                                            productId: product
                                                                .productId,
                                                            quantity: 1,
                                                          );
                                                    },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        "This product is soldout ",
                                        style: Styles.textStyleCom22.copyWith(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      AppButton(
                                        text: "Unavailable",
                                        border: 10,
                                        onTap: null,
                                        backgroundColor: Colors.grey.shade400,
                                      ),
                                    ],
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
      ),
    );
  }
}
