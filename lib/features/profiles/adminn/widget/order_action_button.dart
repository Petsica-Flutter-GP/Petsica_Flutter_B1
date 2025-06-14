import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/features/profiles/adminn/cubit/cancelorderbyadmin%20copy/cancelorderbyadmin_cubit.dart';
import 'package:petsica/features/profiles/adminn/cubit/completeorderbyadmin%20copy/completeorderbyadmin_cubit.dart';
import 'package:petsica/features/profiles/adminn/cubit/completeorderbyadmin/completeorderbyadmin_cubit.dart';

class OrderActionsButtons extends StatelessWidget {
  final int orderId;

  const OrderActionsButtons({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 12, top: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kAddPetTextColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              context.read<CancelOrderCubit>().cancelOrder(orderId as int);
            },
            child: const Text('Cancel',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              context.read<CompleteOrderCubit>().completeOrder(orderId);
            },
            child: const Text('Done',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
