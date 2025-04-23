class CartItemModel {
  final int productId;
  final String productName;
  final String photo;
  final double price;
  final double discount;
  final int quantity;
  final bool isAvailable;
  final double subTotal;

  CartItemModel({
    required this.productId,
    required this.productName,
    required this.photo,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.isAvailable,
    required this.subTotal,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      productName: json['productName'],
      photo: json['photo'],
      price: json['price'].toDouble(),
      discount: json['discount'].toDouble(),
      quantity: json['quantity'],
      isAvailable: json['isAvailable'],
      subTotal: json['subTotal'].toDouble(),
    );
  }
}

class CartResponseModel {
  final List<CartItemModel> items;
  final int totalQuantity;
  final double totalPrice;

  CartResponseModel({
    required this.items,
    required this.totalQuantity,
    required this.totalPrice,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      items: List<CartItemModel>.from(json['items'].map((item) => CartItemModel.fromJson(item))),
      totalQuantity: json['totalQuantity'],
      totalPrice: json['totalPrice'].toDouble(),
    );
  }
}
