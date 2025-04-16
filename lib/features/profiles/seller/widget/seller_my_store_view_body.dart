import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/cubit/delete/product_deletion_cubit.dart';
import 'package:petsica/features/profiles/seller/cubit/git/seller_product_cubit.dart';
import 'package:petsica/features/profiles/seller/cubit/git/seller_product_state.dart';
import 'package:petsica/features/profiles/seller/widget/seller_product_card.dart';
import 'package:shimmer/shimmer.dart';

class SellerMyStoreViewBody extends StatelessWidget {
  const SellerMyStoreViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SellerProductsCubit()..fetchProducts()),
        BlocProvider(create: (_) => ProductDeletionCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("My store", style: Styles.textStyleQu28),
          centerTitle: true,
          leading: const AppArrowBack(destination: AppRouter.kSellerProfile),
          actions: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).go(AppRouter.kSellerAddProduct);
              },
              icon: const Icon(Icons.add_circle_outline),
              iconSize: 35,
            )
          ],
        ),
        body: BlocListener<ProductDeletionCubit, ProductDeletionState>(
          listener: (context, state) {
            if (state is ProductDeletionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("✅ Successfully Deleted")),
              );
              context.read<SellerProductsCubit>().fetchProducts();
            } else if (state is ProductDeletionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("❌ ${state.error}")),
              );
            }
          },
          child: BlocBuilder<SellerProductsCubit, SellerProductsState>(
            builder: (context, state) {
              if (state is SellerProductsLoading) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: kProducPriceColor.withOpacity(0.2),
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Card(
                            color: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.grey[300],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: Colors.grey[300],
                                        height: 20,
                                        width: 100,
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        color: Colors.grey[300],
                                        height: 20,
                                        width: 80,
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        color: Colors.grey[300],
                                        height: 20,
                                        width: double.infinity,
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            color: Colors.grey[300],
                                            height: 20,
                                            width: 50,
                                          ),
                                          Container(
                                            color: Colors.grey[300],
                                            height: 20,
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is SellerProductsError) {
                return Center(child: Text(state.message));
              } else if (state is SellerProductsLoaded) {
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(10),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                          childAspectRatio: 0.6,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = state.products[index];
                            return GestureDetector(
                              onTap: () {},
                              child: SellerProductCard(
                                product: product,
                                onDelete: () {
                                  context
                                      .read<ProductDeletionCubit>()
                                      .deleteProduct(product.productId);
                                },
                              ),
                            );
                          },
                          childCount: state.products.length,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
