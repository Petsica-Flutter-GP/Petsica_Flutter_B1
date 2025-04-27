// cubits/seller_orders_state.dart

import 'package:petsica/features/profiles/seller/models/seller_orders_model.dart';

abstract class SellerOrdersState {}

class SellerOrdersInitial extends SellerOrdersState {}

class SellerOrdersLoading extends SellerOrdersState {}

class SellerOrdersSuccess extends SellerOrdersState {
  final List<SellerOrderModel> orders;
  SellerOrdersSuccess(this.orders);
}

class SellerOrdersFailure extends SellerOrdersState {
  final String errorMessage;
  SellerOrdersFailure(this.errorMessage);
}
