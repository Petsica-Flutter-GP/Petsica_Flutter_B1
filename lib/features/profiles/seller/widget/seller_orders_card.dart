import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart'; // استيراد مكتبة Shimmer
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/cubit/orderChangeState/order_change_state_cubit.dart';
import 'package:petsica/features/profiles/seller/models/seller_orders_model.dart';

class SellerOrdersCard extends StatelessWidget {
  final SellerOrderModel?
      order; // يمكن أن تكون null في حالة عدم تحميل البيانات بعد.

  const SellerOrdersCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: kWhiteGroundColor,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: order == null
                    ? _buildShimmerLoading() // إذا كانت البيانات لا تزال قيد التحميل
                    : _buildOrderDetails(),
              ),
              order == null
                  ? _buildShimmerLoading()
                  : _buildOrderAction(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Order #${order?.orderId ?? "loading"}',
          style: Styles.textStyleCom20.copyWith(
            color: kBurgColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          order?.address ?? 'Loading address...',
          style: Styles.textStyleCom16.copyWith(
            color: kProductTxtColor,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderAction(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: order == null
          ? _buildShimmerLoading() // إذا كانت البيانات لا تزال قيد التحميل
          : order!.status
              ? Text(
                  'Done',
                  key: const ValueKey('done'),
                  style: Styles.textStyleCom18.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : AppButton(
                  key: const ValueKey('button'),
                  text: 'Complete',
                  style: Styles.textStyleCom12.copyWith(
                    color: kWhiteGroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  width: 110,
                  height: 55,
                  border: 10,
                  onTap: () {
                    context
                        .read<SellerOrdersChangeCubit>()
                        .markOrderAsCompleted(order!.orderId);
                  },
                ),
    );
  }

  // بناء الـ Shimmer عندما لا تكون البيانات محملة بعد.
  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 20,
        color: Colors.white,
      ),
    );
  }
}
