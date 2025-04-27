import 'package:petsica/features/profiles/seller/models/seller_orders_model.dart';

class SellerOrdersChangeState {
  final List<SellerOrderModel> orders;

  SellerOrdersChangeState({required this.orders});

  SellerOrdersChangeState copyWith({List<SellerOrderModel>? orders}) {
    return SellerOrdersChangeState(
      orders: orders ?? this.orders,
    );
  }
}
