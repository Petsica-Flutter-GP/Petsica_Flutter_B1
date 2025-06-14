import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/sitter/models/sitter_services_model.dart';

class SitterCard extends StatelessWidget {
  final SitterServiceModel service;

  const SitterCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// العنوان
            Text(
              service.title,
              style: Styles.textStyleCom14.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),

            /// الوصف
            Text(
              service.description,
              style: Styles.textStyleCom12.copyWith(color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),

            /// السعر والموقع
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// السعر
                Text(
                  '${service.price.toStringAsFixed(2)} \$',
                  style: Styles.textStyleCom14.copyWith(
                    color: kProducPriceColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// الموقع
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 25, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      service.location,
                      style: Styles.textStyleCom12,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
