import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/store/cubit/ordersC/userCancelOrder/usercancelorder_state.dart';
import 'package:petsica/features/store/cubit/ordersC/userCancelOrder/usercancelorder_cubit.dart';
import 'package:petsica/features/store/cubit/ordersC/userorder/userorder_cubit.dart';
import 'package:petsica/features/store/cubit/ordersC/userorder/userorder_state.dart';
import 'package:petsica/features/store/models/user_order_model.dart';
import 'package:shimmer/shimmer.dart';

class CheckOutViewBody extends StatelessWidget {
  const CheckOutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCancelOrderCubit, UserCancelOrderState>(
      listener: (context, state) {
        if (state is UserCancelOrderSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Order cancelled successfully')),
          );
          BlocProvider.of<UserOrderCubit>(context).fetchUserOrders();
        } else if (state is UserCancelOrderFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ Failed to cancel order: ${state.error}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const AppArrowBack(destination: AppRouter.kCart),
          title: Text('My Orders', style: Styles.textStyleQu28),
          centerTitle: true,
        ),
        body: BlocBuilder<UserOrderCubit, UserOrderState>(
          builder: (context, state) {
            if (state is UserOrderLoading) {
              return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is UserOrderLoaded) {
              if (state.orders.isEmpty) {
                return const Center(child: Text('No orders found.'));
              }

              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final UserOrderModel order = state.orders[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        GoRouter.of(context)
                            .go(AppRouter.kOrderDetails, extra: order.orderID);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Order #${order.orderID}",
                                      style: Styles.textStyleQui20),
                                  Text(
                                      "\$${order.totalPrice.toStringAsFixed(2)}",
                                      style: Styles.textStyleQui18
                                          .copyWith(color: Colors.green)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined,
                                      size: 22),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(order.address,
                                        style: Styles.textStyleCom14,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today_outlined,
                                      size: 18),
                                  const SizedBox(width: 5),
                                  Text(
                                    DateFormat('dd MMM yyyy, hh:mm a').format(
                                        DateTime.parse(order.createdAt)),
                                    style: Styles.textStyleCom14,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.info_outline, size: 22),
                                  const SizedBox(width: 5),
                                  Text(
                                    order.status ? 'Completed' : 'Pending',
                                    style: Styles.textStyleCom14.copyWith(
                                      color: order.status
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Cancel Button
                              if (!order.status)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kProducPriceColor,
                                    ),
                                    onPressed: () {
                                      final scaffoldContext =
                                          context; // احتفظ بالـ context الأصلي

                                      showDialog(
                                        context: scaffoldContext,
                                        builder: (context) => AlertDialog(
                                          content: Text(
                                            'Are you sure you want to cancel this order?',
                                            style: Styles.textStyleCom16,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No',
                                                  style: Styles.textStyleCom16
                                                      .copyWith(
                                                    color: kProductTxtColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  )),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                BlocProvider.of<
                                                            UserCancelOrderCubit>(
                                                        scaffoldContext)
                                                    .cancelOrder(order.orderID);
                                              },
                                              child: Text('Yes',
                                                  style: Styles.textStyleCom16
                                                      .copyWith(
                                                    color: kProductTxtColor,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Text('Cancel Order',
                                        style: Styles.textStyleCom14.copyWith(
                                            color: kWhiteGroundColor)),
                                  ),
                                ),
                              const SizedBox(height: 10),

                              if (order.orderItems.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Products:',
                                        style: Styles.textStyleQui20),
                                    const SizedBox(height: 5),
                                    ...order.orderItems.map(
                                      (item) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          '- ${item.productName}   x${item.quantity}',
                                          style: Styles.textStyleCom16.copyWith(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is UserOrderError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
