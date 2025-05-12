import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/store/cubit/ordersC/userOrderDetails/userorderdetails_cubit.dart';
import 'package:petsica/features/store/cubit/ordersC/userOrderDetails/userorderdetails_state.dart';
import 'package:petsica/features/store/models/order_model.dart';
import 'package:petsica/features/store/models/user_order_model.dart';

class OrderDetailsViewBody extends StatefulWidget {
  final int orderID;

  const OrderDetailsViewBody({super.key, required this.orderID});

  @override
  State<OrderDetailsViewBody> createState() => _OrderDetailsViewBodyState();
}

class _OrderDetailsViewBodyState extends State<OrderDetailsViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();

    // Fetch user order details from the API using orderID
    context.read<UserOrderDetailsCubit>().fetchUserOrder(widget.orderID);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const AppArrowBack(destination: AppRouter.kCheckOut),
        title: Text('Order Details', style: Styles.textStyleQu28),
        centerTitle: true,
      ),
      body: BlocConsumer<UserOrderDetailsCubit, UserOrderDetailsState>(
        listener: (context, state) {
          if (state is UserOrderDetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          }
        },
        builder: (context, state) {
          if (state is UserOrderDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserOrderDetailsLoaded) {
            final order = state.order;
            int totalQuantity =
                order.orderItems.fold(0, (sum, item) => sum + item.quantity);

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth > 600 ? screenWidth * 0.15 : 16,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order #
                  _buildOrderHeader(order.orderID.toString(), order.totalPrice),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1.2),
                  const SizedBox(height: 20),

                  // 🏠 Address
                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    text: order.address,
                  ),
                  const SizedBox(height: 16),

                  // 🕒 Date
                  _buildInfoRow(
                    icon: Icons.calendar_today_outlined,
                    text: DateFormat('dd MMM yyyy, hh:mm a').format(
                      DateTime.parse(order.createdAt),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 📞 Phone Number
                  _buildInfoRow(
                    icon: Icons.phone_outlined,
                    text: order.phoneNumber,
                  ),
                  const SizedBox(height: 16),

                  // 🔄 AnimatedContainer state
                  _buildStatusRow(order.status),
                  const SizedBox(height: 30),

                  // 🛍️ المنتجات مع Animation
                  Text(
                    'Products:',
                    style: Styles.textStyleQui28,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Total Quantity: $totalQuantity',
                    style: Styles.textStyleCom18
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: order.orderItems
                            .map((product) => _buildProductItem(product))
                            .toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          } else if (state is UserOrderDetailsError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildOrderHeader(String orderId, double totalPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Order #$orderId",
          style: Styles.textStyleQui28,
        ),
        Text(
          "\$${totalPrice.toStringAsFixed(2)}",
          style: Styles.textStyleQui20.copyWith(color: Colors.green),
        ),
      ],
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 28, color: kProductTxtColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Styles.textStyleCom18,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(bool status) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: status
                ? Colors.green.withOpacity(0.2)
                : Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 22,
                color: status ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 6),
              Text(
                status ? 'Completed' : 'Pending',
                style: Styles.textStyleCom16.copyWith(
                  color: status ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductItem(OrderItemModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 30, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "- ${product.productName} x${product.quantity}",
              style: Styles.textStyleCom20.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            "\$${(product.price * product.quantity).toStringAsFixed(2)}",
            style: Styles.textStyleQui18.copyWith(color: Colors.green),
          ),
        ],
      ),
    );
  }
}

Widget _buildOrderHeader(String orderId, double totalPrice) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Order #$orderId",
        style: Styles.textStyleQui28,
      ),
      Text(
        "\$${totalPrice.toStringAsFixed(2)}",
        style: Styles.textStyleQui20.copyWith(color: Colors.green),
      ),
    ],
  );
}

Widget _buildInfoRow({required IconData icon, required String text}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 28, color: kProductTxtColor),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: Styles.textStyleCom18,
        ),
      ),
    ],
  );
}

Widget _buildStatusRow(bool status) {
  return Row(
    children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: status
              ? Colors.green.withOpacity(0.2)
              : Colors.orange.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 22,
              color: status ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 6),
            Text(
              status ? 'Completed' : 'Pending',
              style: Styles.textStyleCom16.copyWith(
                color: status ? Colors.green : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildProductItem(OrderItemModel product) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        const Icon(Icons.check_circle_outline, size: 30, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "- ${product.productName} x${product.quantity}",
            style: Styles.textStyleCom20.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
