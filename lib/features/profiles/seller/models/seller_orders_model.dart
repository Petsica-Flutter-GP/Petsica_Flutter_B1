class SellerOrderModel {
  final int orderId;
  final double totalPrice;
  final String createdAt;
  final bool status;
  final String address;
  final List<OrderItem> orderItems;

  SellerOrderModel({
    required this.orderId,
    required this.totalPrice,
    required this.createdAt,
    required this.status,
    required this.address,
    required this.orderItems,
  });

  // Add copyWith method to allow copying with changes
  SellerOrderModel copyWith({
    int? orderId,
    double? totalPrice,
    String? createdAt,
    bool? status,
    String? address,
    List<OrderItem>? orderItems,
  }) {
    return SellerOrderModel(
      orderId: orderId ?? this.orderId,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      address: address ?? this.address,
      orderItems: orderItems ?? this.orderItems,
    );
  }

  factory SellerOrderModel.fromJson(Map<String, dynamic> json) {
    return SellerOrderModel(
      orderId: json['orderID'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      createdAt: json['createdAt'],
      status: json['status'],
      address: json['address'],
      orderItems: (json['orderItems'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }
}

class OrderItem {
  final int productId;
  final String productName;
  final int quantity;
  final double price;
  final double totalPrice;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  // Add copyWith method for OrderItem as well
  OrderItem copyWith({
    int? productId,
    String? productName,
    int? quantity,
    double? price,
    double? totalPrice,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}
