import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/features/profiles/seller/models/seller_orders_model.dart';

class SellerOrderService {
  // هنا تعريف ثابت لقاعدة الرابط العام (Base URL)
  static const String _baseUrl = 'http://petsica.runasp.net/api';

  static Future<List<SellerOrderModel>> getSellerOrders() async {
    try {
      final token = await TokenStorage.getAccessToken();

      const url =
          '$_baseUrl/Orders/sellerorders'; // نضيف المسار المناسب بعد baseUrl

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log('📩 Response Status Code: ${response.statusCode}');
      log('📦 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = jsonDecode(response.body);

        return decodedData
            .map((order) => SellerOrderModel.fromJson(order))
            .toList();
      } else {
        log('❌ Failed to fetch seller orders: ${response.reasonPhrase}');
        throw Exception('Failed to load seller orders');
      }
    } catch (e) {
      log('🚨 Error in getSellerOrders: $e');
      throw Exception('Something went wrong');
    }
  }

  // دالة لجلب طلب معين حسب ال ID (مسار: /seller/{id})
  static Future<SellerOrderByIdModel> getSellerOrderByID(
      int sellerOrderId) async {
    try {
      final token = await TokenStorage.getAccessToken();

      final url =
          '$_baseUrl/Orders/seller/$sellerOrderId'; // إضافة ال id مع المسار المناسب

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log('📩 Response Status Code: ${response.statusCode}');
      log('📦 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);

        return SellerOrderByIdModel.fromJson(decodedData);
      } else {
        log('❌ Failed to fetch seller order by ID: ${response.reasonPhrase}');
        throw Exception('Failed to load seller order by ID');
      }
    } catch (e) {
      log('🚨 Error in getSellerOrderByID: $e');
      throw Exception('Something went wrong');
    }
  }
}
