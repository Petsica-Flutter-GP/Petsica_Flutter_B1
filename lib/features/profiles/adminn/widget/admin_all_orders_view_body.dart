import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/adminn/cubit/completeorderbyadmin/completeorderbyadmin_cubit.dart';
import 'package:petsica/features/profiles/adminn/cubit/completeorderbyadmin/completeorderbyadmin_state.dart';
import 'package:petsica/features/profiles/adminn/cubit/getallordersbyadmin/getallordersbyadmin_cubit.dart';
import 'package:petsica/features/profiles/adminn/cubit/getallordersbyadmin/getallordersbyadmin_state.dart';

class AdminAllOrdersViewBody extends StatelessWidget {
  const AdminAllOrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AdminOrdersCubit()..fetchAllOrders()),
        BlocProvider(create: (_) => CompleteOrderCubit()),
      ],
      child: BlocListener<CompleteOrderCubit, CompleteOrderState>(
        listener: (context, state) {
          if (state is CompleteOrderLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Completing order...')),
            );
          } else if (state is CompleteOrderSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order completed successfully!')),
            );
            // إعادة تحميل الطلبات
            context.read<AdminOrdersCubit>().fetchAllOrders();
          } else if (state is CompleteOrderErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed: ${state.message}')),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('All Orders', style: Styles.textStyleQu28),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading:
                const AppArrowBack(destination: AppRouter.kChooseOrderScreen),
            elevation: 0,
          ),
          body: BlocBuilder<AdminOrdersCubit, AdminOrdersState>(
            builder: (context, state) {
              if (state is AdminOrdersLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AdminOrdersLoaded) {
                if (state.orders.isEmpty) {
                  return const Center(
                    child: Text(
                      'No orders available yet',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    final order = state.orders[index];

                    final orderID = order['orderID'] ?? '';
                    final totalQuantity = order['totalQuantity'] ?? 0;
                    final totalPrice = order['totalPrice'] ?? 0.0;
                    final createdAt = order['createdAt'] ?? '';
                    final status = order['status'] ?? false;
                    final address = order['address'] ?? '';
                    final orderItems =
                        order['orderItems'] as List<dynamic>? ?? [];
                    final sellerOrderId = order['sellerOrderId'] ?? '';
                    final isCancelled = order['isCancelled'] ?? false;
                    final orderId = order['orderId'] ?? '';

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          'Order #$orderID',
                          style:
                              Styles.textStyleCom24.copyWith(color: kBurgColor),
                        ),
                        subtitle: Text(
                          'Quantity: $totalQuantity | Total Price: ${totalPrice.toStringAsFixed(2)} EGP',
                          style: Styles.textStyleCom16
                              .copyWith(color: Colors.grey.shade700),
                        ),
                        trailing: Icon(
                          status ? Icons.check_circle : Icons.pending,
                          color: status ? Colors.green : kProducPriceColor,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order Date: ${createdAt.isNotEmpty ? DateFormat('dd/MM/yyyy - hh:mm a').format(DateTime.parse(createdAt)) : 'N/A'}',
                                  style: Styles.textStyleCom18.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Address: $address',
                                  style: Styles.textStyleCom18
                                      .copyWith(color: Colors.black87),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Cancelled: ${isCancelled ? 'Yes' : 'No'}',
                                  style: Styles.textStyleCom18.copyWith(
                                    color: isCancelled
                                        ? Colors.red
                                        : const Color.fromARGB(
                                            255, 42, 233, 48),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Status: ${status ? 'True' : 'False'}',
                                  style: Styles.textStyleCom18.copyWith(
                                    color: isCancelled
                                        ? const Color.fromARGB(255, 42, 233, 48)
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Items:',
                                  style: Styles.textStyleCom18
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                ...orderItems.map((item) {
                                  final productName = item['productName'] ?? '';
                                  final quantity = item['quantity'] ?? 0;
                                  final price = item['price'] ?? 0.0;
                                  final totalPriceItem =
                                      item['totalPrice'] ?? 0.0;

                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    child: Wrap(
                                      spacing: 10,
                                      runSpacing: 6,
                                      children: [
                                        Text(
                                          productName,
                                          style: Styles.textStyleCom18.copyWith(
                                            color: kBurgColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Qty: $quantity',
                                          style: Styles.textStyleCom16.copyWith(
                                              color: Colors.grey.shade800),
                                        ),
                                        Text(
                                          'Price: ${price.toStringAsFixed(2)} EGP',
                                          style: Styles.textStyleCom16.copyWith(
                                              color: Colors.grey.shade800),
                                        ),
                                        Text(
                                          'Total: ${totalPriceItem.toStringAsFixed(2)} EGP',
                                          style: Styles.textStyleCom16.copyWith(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: kAddPetTextColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          // تنفيذ إلغاء الطلب لاحقًا
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          context
                                              .read<CompleteOrderCubit>()
                                              .completeOrder(orderID);
                                        },
                                        child: const Text(
                                          'Done',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is AdminOrdersError) {
                return Center(
                  child: Text(
                    'Error occurred: ${state.message}',
                    style:
                        const TextStyle(fontSize: 18, color: Colors.redAccent),
                  ),
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
