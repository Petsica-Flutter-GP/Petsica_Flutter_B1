import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/styles.dart';

class OrderItemsList extends StatelessWidget {
  final List items;

  const OrderItemsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Items:',
            style: Styles.textStyleCom18.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        ...items.map((item) {
          final name = item['productName'] ?? '';
          final qty = item['quantity'] ?? 0;
          final price = item['price'] ?? 0.0;
          final total = item['totalPrice'] ?? 0.0;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Wrap(
              spacing: 10,
              runSpacing: 6,
              children: [
                Text(name,
                    style: Styles.textStyleCom18.copyWith(
                      color: kBurgColor,
                      fontWeight: FontWeight.w600,
                    )),
                Text('Qty: $qty', style: Styles.textStyleCom16),
                Text('Price: ${price.toStringAsFixed(2)} EGP',
                    style: Styles.textStyleCom16),
                Text('Total: ${total.toStringAsFixed(2)} EGP',
                    style: Styles.textStyleCom16
                        .copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          );
        }),
      ],
    );
  }
}
