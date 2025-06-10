import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/adminn/widget/order_action_button.dart';
import 'package:petsica/features/profiles/adminn/widget/order_info_tile.dart';
import 'package:petsica/features/profiles/adminn/widget/order_list_item.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final orderId = order['orderID'] ?? '';
    final totalQuantity = order['totalQuantity'] ?? 0;
    final totalPrice = order['totalPrice'] ?? 0.0;
    final status = order['status'] ?? false;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(
          'Order #$orderId',
          style: Styles.textStyleCom24.copyWith(color: kBurgColor),
        ),
        subtitle: Text(
          'Quantity: $totalQuantity | Total Price: ${totalPrice.toStringAsFixed(2)} EGP',
          style: Styles.textStyleCom16.copyWith(color: Colors.grey.shade700),
        ),
        trailing: Icon(
          status ? Icons.check_circle : Icons.pending,
          color: status ? Colors.green : kProducPriceColor,
        ),
        children: [
          OrderInfoTile(order: order),
          const SizedBox(height: 8),
          OrderItemsList(items: order['orderItems'] ?? []),
          const SizedBox(height: 12),
          OrderActionsButtons(orderId: orderId),
        ],
      ),
    );
  }
}
