import 'package:petsica/features/store/models/order_model.dart';

class UserOrderModel {
  final int orderID;
  final String userId;
  final double totalPrice;
  final int totalQuantity;
  final String createdAt;
  final bool status;
  final String phoneNumber;
  final String address;
  final List<OrderItemModel> orderItems;

  UserOrderModel({
    required this.orderID,
    required this.userId,
    required this.totalPrice,
    required this.totalQuantity,
    required this.createdAt,
    required this.status,
    required this.phoneNumber,
    required this.address,
    required this.orderItems,
  });

  factory UserOrderModel.fromJson(Map<String, dynamic> json) {
    var list = json['orderItems'] as List;
    List<OrderItemModel> orderItemsList = list.map((i) => OrderItemModel.fromJson(i)).toList();

    return UserOrderModel(
      orderID: json['orderID'],
      userId: json['userId'],
      totalPrice: json['totalPrice'],
      totalQuantity: json['totalQuantity'],
      createdAt: json['createdAt'],
      status: json['status'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      orderItems: orderItemsList,
    );
  }
}


