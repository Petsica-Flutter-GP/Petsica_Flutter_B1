import 'package:flutter/material.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:intl/intl.dart';
class OrderInfoTile extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderInfoTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final createdAt = order['createdAt'] ?? '';
    final address = order['address'] ?? '';
    final isCancelled = order['isCancelled'] ?? false;
    final status = order['status'] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Date: ${createdAt.isNotEmpty ? DateFormat('dd/MM/yyyy - hh:mm a').format(DateTime.parse(createdAt)) : 'N/A'}',
            style: Styles.textStyleCom18.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('Address: $address', style: Styles.textStyleCom18),
          const SizedBox(height: 6),
          Text(
            'Cancelled: ${isCancelled ? 'Yes' : 'No'}',
            style: Styles.textStyleCom18.copyWith(
              color: isCancelled ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Status: ${status ? 'Done' : 'Pending'}',
            style: Styles.textStyleCom18.copyWith(
              color: status ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
