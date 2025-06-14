// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:petsica/core/constants.dart';
// import 'package:petsica/core/utils/app_arrow_back.dart';
// import 'package:petsica/core/utils/app_router.dart';
// import 'package:petsica/core/utils/styles.dart';
// import 'package:petsica/features/profiles/seller/cubit/getOrderByID/get_seller_order_by_id_cubit.dart';
// import 'package:petsica/features/profiles/seller/cubit/getOrderByID/get_seller_order_by_id_state.dart';
// import 'package:petsica/features/profiles/seller/models/seller_orders_model.dart';

// class SellerOrderDetailsViewBody extends StatelessWidget {
//   const SellerOrderDetailsViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GetSellerOrderByIdCubit, GetSellerOrderByIdState>(
//       builder: (context, state) {
//         if (state is GetSellerOrderByIdLoading) {
//           return const Scaffold(
//             backgroundColor: kAppColor,
//             body: Center(
//               child: CircularProgressIndicator(color: Colors.white),
//             ),
//           );
//         } else if (state is GetSellerOrderByIdError) {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text("Order Details", style: Styles.textStyleQu28),
//               centerTitle: true,
//               leading: const AppArrowBack(destination: AppRouter.kSellerOrders),
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('Error occurred: ${state.message}',
//                       style: Styles.textStyleCom18),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           );
//         } else if (state is GetSellerOrderByIdLoaded) {
//           final SellerOrderByIdModel order = state.order;

//           return Scaffold(
//             backgroundColor: Colors.grey[50], // خلفية فاتحة خفيفة
//             appBar: AppBar(
//               title: Text("Order Details", style: Styles.textStyleQu28),
//               centerTitle: true,
//               leading: const AppArrowBack(destination: AppRouter.kSellerOrders),
//             ),
//             body: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Card(
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     margin: const EdgeInsets.only(bottom: 24),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Order Number: #${order.orderId}',
//                             style: Styles.textStyleQu28.copyWith(
//                                 fontWeight: FontWeight.bold, color: kBurgColor),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Created on: ${DateFormat('yyyy-MM-dd – hh:mm a').format(DateTime.parse(order.createdAt))}',
//                             style: Styles.textStyleQui18
//                                 .copyWith(color: Colors.grey[600]),
//                           ),
//                           // إزالة السطر الخاص بـ address لأنه غير موجود
//                           // إذا عندك العنوان أضفه في الموديل وهنا
//                           const SizedBox(height: 16),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Status: ',
//                                   style: Styles.textStyleCom18
//                                       .copyWith(fontWeight: FontWeight.bold)),
//                               const SizedBox(width: 8),
//                               Chip(
//                                 label: Text(order.isCancelled
//                                     ? 'Cancelled ❌'
//                                     : 'Completed ✅'),
//                                 backgroundColor: order.isCancelled
//                                     ? Colors.red[100]
//                                     : Colors.green[100],
//                                 labelStyle: TextStyle(
//                                   color: order.isCancelled
//                                       ? Colors.red
//                                       : Colors.green[800],
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           Text('Total Quantity: ${order.totalQuantity}',
//                               style: Styles.textStyleCom18
//                                   .copyWith(fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 8),
//                           Text('Total Price: ${order.totalPrice} LE',
//                               style: Styles.textStyleCom18
//                                   .copyWith(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Text('Order Items:',
//                       style: Styles.textStyleQui20
//                           .copyWith(fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 8),
//                   ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: order.orderItems.length,
//                     separatorBuilder: (_, __) => const Divider(),
//                     itemBuilder: (context, index) {
//                       final item = order.orderItems[index];
//                       return ListTile(
//                         contentPadding: EdgeInsets.zero,
//                         leading: CircleAvatar(
//                           backgroundColor: kBurgColor.withOpacity(0.1),
//                           child: const Icon(Icons.pets, color: kBurgColor),
//                         ),
//                         title: Text(item.productName,
//                             style: Styles.textStyleCom18
//                                 .copyWith(fontWeight: FontWeight.bold)),
//                         subtitle: Text('Quantity: ${item.quantity}',
//                             style: Styles.textStyleCom16
//                                 .copyWith(color: Colors.grey[700])),
//                         trailing: Text('${item.totalPrice} LE',
//                             style: Styles.textStyleCom18
//                                 .copyWith(fontWeight: FontWeight.bold)),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         } else {
//           return const SizedBox();
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/cubit/getOrderByID/get_seller_order_by_id_cubit.dart';
import 'package:petsica/features/profiles/seller/cubit/getOrderByID/get_seller_order_by_id_state.dart';
import 'package:petsica/features/profiles/seller/models/seller_orders_model.dart';

class SellerOrderDetailsViewBody extends StatelessWidget {
  const SellerOrderDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSellerOrderByIdCubit, GetSellerOrderByIdState>(
      builder: (context, state) {
        if (state is GetSellerOrderByIdLoading) {
          return const Scaffold(
            backgroundColor: kAppColor,
            body: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        } else if (state is GetSellerOrderByIdError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Order Details", style: Styles.textStyleQu28),
              centerTitle: true,
              leading: const AppArrowBack(destination: AppRouter.kSellerOrders),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Color.fromARGB(255, 190, 37, 50), size: 64),
                    const SizedBox(height: 16),
                    Text(
                      'Oops! Something went wrong.',
                      style: Styles.textStyleQu28.copyWith(
                        color: const Color.fromARGB(255, 190, 37, 50),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'We couldn\'t load the order details.\nPlease check your connection or try again later.',
                      style: Styles.textStyleCom18
                          .copyWith(color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        } else if (state is GetSellerOrderByIdLoaded) {
          final SellerOrderByIdModel order = state.order;

          return Scaffold(
            backgroundColor: Colors.grey[50], // Light background
            appBar: AppBar(
              title: Text("Order Details", style: Styles.textStyleQu28),
              centerTitle: true,
              leading: const AppArrowBack(destination: AppRouter.kSellerOrders),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Number: #${order.orderId}',
                            style: Styles.textStyleQu28.copyWith(
                                fontWeight: FontWeight.bold, color: kBurgColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Created on: ${DateFormat('yyyy-MM-dd – hh:mm a').format(DateTime.parse(order.createdAt))}',
                            style: Styles.textStyleQui18
                                .copyWith(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Status: ',
                                  style: Styles.textStyleCom18
                                      .copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              Chip(
                                label: Text(order.isCancelled
                                    ? 'Cancelled'
                                    : 'Completed'),
                                backgroundColor: order.isCancelled
                                    ? Colors.red[100]
                                    : Colors.green[100],
                                labelStyle: TextStyle(
                                  color: order.isCancelled
                                      ? Colors.red
                                      : Colors.green[800],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text('Total Quantity: ${order.totalQuantity}',
                              style: Styles.textStyleCom18
                                  .copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('Total Price: ${order.totalPrice} LE',
                              style: Styles.textStyleCom18
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Text('Order Items:',
                      style: Styles.textStyleQui20
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: order.orderItems.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = order.orderItems[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: kBurgColor.withOpacity(0.1),
                          child: const Icon(Icons.pets, color: kBurgColor),
                        ),
                        title: Text(item.productName,
                            style: Styles.textStyleCom18
                                .copyWith(fontWeight: FontWeight.bold)),
                        subtitle: Text('Quantity: ${item.quantity}',
                            style: Styles.textStyleCom16
                                .copyWith(color: Colors.grey[700])),
                        trailing: Text('${item.totalPrice} LE',
                            style: Styles.textStyleCom18
                                .copyWith(fontWeight: FontWeight.bold)),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
