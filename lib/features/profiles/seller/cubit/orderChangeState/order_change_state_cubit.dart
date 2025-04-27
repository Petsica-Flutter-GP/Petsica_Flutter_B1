import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/orderChangeState/order_change_state_state.dart';
import 'package:petsica/features/profiles/seller/models/seller_orders_model.dart';
import 'package:petsica/features/profiles/seller/services/seller_orders_service.dart';

class SellerOrdersChangeCubit extends Cubit<SellerOrdersChangeState> {
  SellerOrdersChangeCubit() : super(SellerOrdersChangeState(orders: []));  // تحديد الحالة الابتدائية

  // دالة لتحديث حالة الطلبات
  void setOrders(List<SellerOrderModel> newOrders) {
    emit(state.copyWith(orders: newOrders));  // استخدام copyWith لتحديث قائمة الطلبات
  }

  // دالة لتغيير حالة الطلب إلى مكتمل
  void markOrderAsCompleted(int orderId) {
    final updatedOrders = state.orders.map((order) {
      if (order.orderId == orderId) {
        return order.copyWith(status: true);  // تحديث حالة الطلب إلى مكتمل
      }
      return order;
    }).toList();

    emit(state.copyWith(orders: updatedOrders));  // تحديث الحالة بعد التعديل
  }

  // دالة لتحميل الطلبات من الـ API
  Future<void> loadOrders() async {
    try {
      final orders = await SellerOrderService.getSellerOrders();  // استدعاء الخدمة لجلب الطلبات
      emit(state.copyWith(orders: orders));  // تحديث الحالة بالقائمة المحملة من الـ API
    } catch (e) {
      emit(state.copyWith(orders: []));  // في حال حدوث خطأ، نعيد حالة فارغة
      print('Error loading orders: $e');
    }
  }
}
