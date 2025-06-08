import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/cubit/orderChangeState/order_change_state_cubit.dart';
import 'package:petsica/features/profiles/seller/models/seller_orders_model.dart';

class SellerOrdersCard extends StatefulWidget {
  final SellerOrderModel? order;
  final int index;

  const SellerOrdersCard({
    super.key,
    required this.order,
    required this.index,
  });

  @override
  State<SellerOrdersCard> createState() => _SellerOrdersCardState();
}

class _SellerOrdersCardState extends State<SellerOrdersCard> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      color: kWhiteGroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: widget.order == null
            ? null
            : () {
                debugPrint('Tapped on order #${widget.order!.orderId}');
                if (widget.order?.orderId != null) {
                  GoRouter.of(context).go(
                    AppRouter.kSellerOrderDetails,
                    extra: widget.order!.orderId,
                  );
                } else {
                  print('Order ID is null!');
                }
              },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.12,
                height: screenWidth * 0.12,
                decoration: BoxDecoration(
                  color: kAppColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: screenWidth * 0.08,
                  color: kAppColor,
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: widget.order == null
                    ? _buildShimmerLoading()
                    : _buildOrderDetails(),
              ),
              SizedBox(width: screenWidth * 0.04),
              widget.order == null
                  ? _buildShimmerLoading(width: screenWidth * 0.25, height: 40)
                  : _buildOrderAction(context,
                      width: screenWidth * 0.25, height: 45),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Order #${widget.index + 1} ',
          style: Styles.textStyleCom20.copyWith(
            color: kBurgColor,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        if (widget.order?.createdAt != null)
          Text(
            'Created at: ${DateFormat('dd/MM/yyyy - hh:mm a').format(DateTime.parse(widget.order!.createdAt))}',
            style: Styles.textStyleCom14.copyWith(
              color: Colors.grey[600],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  Widget _buildOrderAction(BuildContext context,
      {double width = 110, double height = 45}) {
    final isCompleted = widget.order?.status == true || isDone;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: isCompleted
          ? Container(
              key: const ValueKey('done'),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Text(
                'Completed',
                style: Styles.textStyleCom20.copyWith(
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : SizedBox(
              width: width,
              height: height,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBurgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(110, 45),
                ),
                onPressed: () {
                  if (widget.order?.orderId != null) {
                    print(
                        '🟢 Trying to complete order ID: ${widget.order!.orderId}');
                    context
                        .read<SellerOrderCompleteCubit>()
                        .completeOrder(widget.order!.sellerOrderId);
                    setState(() {
                      isDone = true;
                    });
                  }
                },
                child: Text(
                  'Done',
                  style: Styles.textStyleCom18.copyWith(
                    color: kWhiteGroundColor,
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildShimmerLoading(
      {double width = double.infinity, double height = 20}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
