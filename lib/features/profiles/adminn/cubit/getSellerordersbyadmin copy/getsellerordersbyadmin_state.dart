abstract class AdminSellerOrdersState {}

class AdminSellerOrderInitial extends AdminSellerOrdersState {}

class AdminSellerOrderLoading extends AdminSellerOrdersState {}

class AdminSellerOrderLoaded extends AdminSellerOrdersState {
  final List<dynamic> orders;

  AdminSellerOrderLoaded(this.orders);
}

class AdminSellerOrderError extends AdminSellerOrdersState {
  final String message;

  AdminSellerOrderError(this.message);
}
