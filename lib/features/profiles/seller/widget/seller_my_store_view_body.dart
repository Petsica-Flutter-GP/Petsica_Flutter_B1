import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/cubit/delete/product_deletion_cubit.dart';
import 'package:petsica/features/profiles/seller/cubit/git/seller_product_cubit.dart';
import 'package:petsica/features/profiles/seller/cubit/git/seller_product_state.dart';
import 'package:petsica/features/profiles/seller/cubit/soldOut/soldout_cubit.dart';
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
        BlocProvider(create: (_) => SoldOutCubit()),
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
                SnackBar(content: Text("❌ ${state.message}")),
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
                if (state.products.isEmpty) {
                  return const Stack(
                    children: [
                      Center(
                          child: Text("No products yet 🛒",
                              style: TextStyle(fontSize: 20))),
                    ],
                  );
                }

                // باقي الحالة العادية لو في منتجات
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

// class AnimatedArrowHint extends StatefulWidget {
//   const AnimatedArrowHint({super.key});

//   @override
//   State<AnimatedArrowHint> createState() => _AnimatedArrowHintState();
// }

// class _AnimatedArrowHintState extends State<AnimatedArrowHint>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _offsetAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     )..repeat(reverse: true);

//     _offsetAnimation =
//         Tween<Offset>(begin: const Offset(0, -0.3), end: const Offset(0, 0.3))
//             .animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SlideTransition(
//       position: _offsetAnimation,
//       child: Row(
//         children: [
//           Text(
//             'Add Product',
//             style: Styles.textStyleCom22,
//           ),
//           const Icon(Icons.north, size: 40, color: kBurgColor),
//         ],
//       ),
//     );
//   }
// }

// class CurvedArrowPainter extends CustomPainter {
//   final double progress;

//   CurvedArrowPainter(this.progress);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.orange
//       ..strokeWidth = 4
//       ..style = PaintingStyle.stroke;

//     final path = Path();

//     // من منتصف الشاشة إلى أعلى اليمين
//     path.moveTo(size.width / 2, size.height / 2);

//     // المسار المموج
//     path.quadraticBezierTo(
//       size.width * 0.75,
//       size.height * 0.35,
//       size.width * progress,
//       0,
//     );

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CurvedArrowPainter oldDelegate) {
//     return oldDelegate.progress != progress;
//   }
// }

// class AnimatedArrow extends StatefulWidget {
//   const AnimatedArrow({super.key});

//   @override
//   State<AnimatedArrow> createState() => _AnimatedArrowState();
// }

// class _AnimatedArrowState extends State<AnimatedArrow>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);

//     _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (_, __) {
//         return CustomPaint(
//           size: MediaQuery.of(context).size,
//           painter: CurvedArrowPainter(_animation.value),
//         );
//       },
//     );
//   }
// }
