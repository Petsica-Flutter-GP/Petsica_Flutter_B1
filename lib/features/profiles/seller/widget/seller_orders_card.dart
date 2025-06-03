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

class SellerOrdersCard extends StatelessWidget {
  final SellerOrderModel? order;

  const SellerOrdersCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery لأخذ عرض وارتفاع الشاشة
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      color: kWhiteGroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: order == null
            ? null
            : () {
                debugPrint('Tapped on order #${order!.orderId}');
                if (order?.orderId != null) {
                  GoRouter.of(context).go(
                    AppRouter.kSellerOrderDetails,
                    extra: order!.orderId, // بعد التحقق نقدر نستخدم !
                  );
                } else {
                  // ممكن تعرضي رسالة أو تتجاهلي الضغط
                  print('Order ID is null!');
                }
              },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // الأيقونة مع أبعاد متناسبة
              Container(
                width: screenWidth * 0.12, // تقريبا 12% من عرض الشاشة
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
              // تفاصيل الطلب مع Expanded ليأخذ المساحة المتاحة
              Expanded(
                child: order == null
                    ? _buildShimmerLoading()
                    : _buildOrderDetails(),
              ),
              SizedBox(width: screenWidth * 0.04),
              // زر الإجراء مع حجم متناسب
              order == null
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
      mainAxisSize: MainAxisSize.min, // مهم جدا لتجنب overflow
      children: [
        Text(
          'Order #${order?.orderId ?? "loading"}',
          style: Styles.textStyleCom20.copyWith(
            color: kBurgColor,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        if (order?.createdAt != null)
          Text(
            order?.createdAt != null
                ? 'Created at: ${DateFormat('dd/MM/yyyy - hh:mm a').format(DateTime.parse(order!.createdAt))}'
                : 'Loading...',
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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: order?.status == true
          ? Container(
              key: const ValueKey('done'),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Done',
                style: Styles.textStyleCom18.copyWith(
                  color: Colors.green[700],
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
                    borderRadius:
                        BorderRadius.circular(10), // مثلا نفس قيمة border 10
                  ),
                  minimumSize: const Size(110, 45), // نفس الحجم السابق لو تحب
                ),
                onPressed: () {
                  final id = order?.orderId;
                  if (id != null) {
                    context
                        .read<SellerOrdersChangeCubit>()
                        .markOrderAsCompleted(id);
                  } else {
                    debugPrint('❌ Order ID is null, cannot complete order.');
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
