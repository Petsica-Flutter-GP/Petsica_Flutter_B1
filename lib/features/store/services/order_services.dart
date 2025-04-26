import 'dart:convert';

import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/store/models/user_order_model.dart';

class OrderService {
  static Future<void> makeOrder(String address) async {
    final url = Uri.parse('http://petsica.runasp.net/api/orders/create');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'POST',
        body: jsonEncode({'address': address}),
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

        final orders = data.map((order) => UserOrderModel.fromJson(order)).toList();

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

}
