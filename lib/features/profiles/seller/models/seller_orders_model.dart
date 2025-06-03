// class SellerOrderModel {
//   final int orderId;
//   final double totalPrice;
//   final String createdAt;
//   final bool status;
//   final String address;
//   final List<OrderItem> orderItems;

//   SellerOrderModel({
//     required this.orderId,
//     required this.totalPrice,
//     required this.createdAt,
//     required this.status,
//     required this.address,
//     required this.orderItems,
//   });

//   // Add copyWith method to allow copying with changes
//   SellerOrderModel copyWith({
//     int? orderId,
//     double? totalPrice,
//     String? createdAt,
//     bool? status,
//     String? address,
//     List<OrderItem>? orderItems,
//   }) {
//     return SellerOrderModel(
//       orderId: orderId ?? this.orderId,
//       totalPrice: totalPrice ?? this.totalPrice,
//       createdAt: createdAt ?? this.createdAt,
//       status: status ?? this.status,
//       address: address ?? this.address,
//       orderItems: orderItems ?? this.orderItems,
//     );
//   }

//   factory SellerOrderModel.fromJson(Map<String, dynamic> json) {
//     return SellerOrderModel(
//       orderId: json['orderID'],
//       totalPrice: (json['totalPrice'] as num).toDouble(),
//       createdAt: json['createdAt'],
//       status: json['status'],
//       address: json['address'],
//       orderItems: (json['orderItems'] as List)
//           .map((item) => OrderItem.fromJson(item))
//           .toList(),
//     );
//   }
// }

class SellerOrderModel {
  final int sellerOrderId;
  final String sellerId;
  final int orderId;
  final String createdAt;
  final int totalQuantity;
  final double totalPrice;
  final bool status;
  final bool isCancelled;
  final List<OrderItemModelForSeller> orderItems;

  SellerOrderModel({
    required this.sellerOrderId,
    required this.sellerId,
    required this.orderId,
    required this.createdAt,
    required this.totalQuantity,
    required this.totalPrice,
    required this.status,
    required this.isCancelled,
    required this.orderItems,
  });

  factory SellerOrderModel.fromJson(Map<String, dynamic> json) {
    return SellerOrderModel(
      sellerOrderId: json['sellerOrderId'],
      sellerId: json['sellerId'],
      orderId: json['orderId'],
      createdAt: json['createdAt'],
      totalQuantity: json['totalQuantity'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'],
      isCancelled: json['isCancelled'],
      orderItems: (json['orderItems'] as List)
          .map((item) => OrderItemModelForSeller.fromJson(item))
          .toList(),
    );
  }

    SellerOrderModel copyWith({
    int? sellerOrderId,
    String? sellerId,
    int? orderId,
    String? createdAt,
    int? totalQuantity,
    double? totalPrice,
    bool? status,
    bool? isCancelled,
    List<OrderItemModelForSeller>? orderItems,
  }) {
    return SellerOrderModel(
      sellerOrderId: sellerOrderId ?? this.sellerOrderId,
      sellerId: sellerId ?? this.sellerId,
      orderId: orderId ?? this.orderId,
      createdAt: createdAt ?? this.createdAt,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      isCancelled: isCancelled ?? this.isCancelled,
      orderItems: orderItems ?? this.orderItems,
    );
  }

}


class OrderItemModelForSeller {
  final int productId;
  final String productName;
  final String photo;
  final int quantity;
  final double price;
  final double totalPrice;

  OrderItemModelForSeller({
    required this.productId,
    required this.productName,
    required this.photo,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  factory OrderItemModelForSeller.fromJson(Map<String, dynamic> json) {
    return OrderItemModelForSeller(
      productId: json['productId'],
      productName: json['productName'],
      photo: json['photo'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}


class SellerOrderByIdModel {
  final int sellerOrderId;
  final String sellerId;
  final int orderId;
  final String createdAt;  // هنا سترينغ
  final int totalQuantity;
  final double totalPrice;
  final bool status;
  final bool isCancelled;
  final List<OrderItem> orderItems;

  SellerOrderByIdModel({
    required this.sellerOrderId,
    required this.sellerId,
    required this.orderId,
    required this.createdAt,
    required this.totalQuantity,
    required this.totalPrice,
    required this.status,
    required this.isCancelled,
    required this.orderItems,
  });

  factory SellerOrderByIdModel.fromJson(Map<String, dynamic> json) {
    return SellerOrderByIdModel(
      sellerOrderId: json['sellerOrderId'],
      sellerId: json['sellerId'],
      orderId: json['orderId'],
      createdAt: json['createdAt'],
      totalQuantity: json['totalQuantity'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'],
      isCancelled: json['isCancelled'],
      orderItems: (json['orderItems'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class OrderItem {
  final int productId;
  final String productName;
  final String photo;
  final int quantity;
  final double price;
  final double totalPrice;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.photo,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      photo: json['photo'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}
