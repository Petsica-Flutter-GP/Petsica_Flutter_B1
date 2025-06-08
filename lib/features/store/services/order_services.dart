import 'dart:convert';

import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/store/models/user_order_model.dart';

class OrderService {
  static Future<void> makeOrder(String address, String phonenumber) async {
    final url = Uri.parse('http://petsica.runasp.net/api/orders/create');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'POST',
        body: jsonEncode({
          'address': address,
          'phonenumber': phonenumber, // إضافة رقم الهاتف
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('✅ Order created successfully');
      } else {
        // طباعة الاستجابة بالكامل للمساعدة في فهم الخطأ
        print('❌ فشل إنشاء الطلب: ${response.statusCode}');
        print('تفاصيل الخطأ: ${response.body}');
        throw Exception('❌ فشل إنشاء الطلب: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ حدث خطأ أثناء إرسال الطلب: $e');
      rethrow; // لإعادة رمي الخطأ بعد تسجيله
    }
  }

//get user order
  static Future<List<UserOrderModel>> getUserOrders() async {
    final url = Uri.parse('http://petsica.runasp.net/api/Orders/userorders');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'GET',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        final orders =
            data.map((order) => UserOrderModel.fromJson(order)).toList();

        print('✅ Orders fetched successfully');
        return orders.cast<UserOrderModel>();
      } else {
        print('❌ فشل في جلب الطلبات: ${response.statusCode}');
        print('تفاصيل الخطأ: ${response.body}');
        throw Exception('❌ فشل في جلب الطلبات: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ حدث خطأ أثناء جلب الطلبات: $e');
      rethrow;
    }
  }

  //get user order details
  static Future<UserOrderModel> getUserOrderById(int orderID) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Orders/$orderID');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'GET',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // تحويل البيانات إلى نموذج UserOrderModel
        final order = UserOrderModel.fromJson(data);

        print('✅ Order fetched successfully');
        return order;
      } else {
        print('❌ فشل في جلب الطلب: ${response.statusCode}');
        print('تفاصيل الخطأ: ${response.body}');
        throw Exception('❌ فشل في جلب الطلب: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ حدث خطأ أثناء جلب الطلب: $e');
      rethrow; // لإعادة رمي الخطأ بعد تسجيله
    }
  }

// user cancel order
// Cancel order by user
  static Future<void> cancelOrderByUser(int orderID) async {
    final url =
        Uri.parse('http://petsica.runasp.net/api/Orders/cancel/$orderID');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'PUT',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _logSuccess(orderID);
      } else {
        await _handleError(response.statusCode, response.body);
      }
    } catch (error) {
      _logException(error);
      rethrow;
    }
  }

  static void _logSuccess(int orderID) {
    print('✅ Order #$orderID canceled successfully.');
  }

  static Future<void> _handleError(int statusCode, String responseBody) async {
    print('❌ Failed to cancel order. Status code: $statusCode');
    print('Error details: $responseBody');
    throw Exception('Failed to cancel order with status code $statusCode');
  }

  static void _logException(dynamic error) {
    print('❌ Exception occurred while canceling order: $error');
  }
}
