import 'package:petsica/features/store/models/order_model.dart';

class UserOrderModel {
  final int orderID;
  final double totalPrice;
  final String createdAt;
  final bool status;
  final String address;
  final List<OrderItemModel> orderItems;

  UserOrderModel({
    required this.orderID,
    required this.totalPrice,
    required this.createdAt,
    required this.status,
    required this.address,
    required this.orderItems,
  });

  factory UserOrderModel.fromJson(Map<String, dynamic> json) {
    return UserOrderModel(
      orderID: json['orderID'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      createdAt: json['createdAt'],
      status: json['status'],
      address: json['address'],
      orderItems: (json['orderItems'] as List)
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
    );
  }
}
