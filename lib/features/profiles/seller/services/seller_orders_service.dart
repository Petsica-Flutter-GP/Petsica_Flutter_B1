import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/features/profiles/seller/models/seller_orders_model.dart';

class SellerOrderService {
  static const String _baseUrl = 'http://petsica.runasp.net/api/Orders/sellerorders';

  static Future<List<SellerOrderModel>> getSellerOrders() async {
    try {
      final token = await TokenStorage.getAccessToken();

      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log('📩 Response Status Code: ${response.statusCode}');
      log('📦 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = jsonDecode(response.body);

        return decodedData.map((order) => SellerOrderModel.fromJson(order)).toList();
      } else {
        log('❌ Failed to fetch seller orders: ${response.reasonPhrase}');
        throw Exception('Failed to load seller orders');
      }
    } catch (e) {
      log('🚨 Error in getSellerOrders: $e');
      throw Exception('Something went wrong');
    }
  }
}
