class OrderItemModel {
  final int productId;
  final String productName;
  final int quantity;
  final double price;
  final double totalPrice;

  OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}
