import 'dart:convert';
import 'dart:developer';

import 'package:petsica/core/utils/send_Authorized_Request.dart';

class AdminServices {
  // ----------------------- Orders Management -----------------------

  /// ✅ Cancel an order by admin
  static Future<void> cancelOrder(int orderId) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Orders/admin/cancel/$orderId');
    await _sendPutRequest(url, 'Order #$orderId canceled successfully by admin.');
  }

  /// ✅ Complete an order by admin
  static Future<void> completeOrder(int orderId) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Orders/admin/complete/$orderId');
    await _sendPutRequest(url, 'Order #$orderId marked as complete by admin.');
  }

  /// ✅ Get all orders
  static Future<List<dynamic>> getAllOrders() async {
    final url = Uri.parse('http://petsica.runasp.net/api/Orders/all');
    return await _sendGetListRequest(url);
  }

  /// ✅ Get all seller orders
  static Future<List<dynamic>> getAllSellerOrders() async {
    final url = Uri.parse('http://petsica.runasp.net/api/Orders/all/sellerorders');
    return await _sendGetListRequest(url);
  }

  /// ✅ Get order by ID
  static Future<dynamic> getOrderById(int orderId) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Orders/admin/$orderId');
    return await _sendGetObjectRequest(url);
  }

  /// ✅ Get seller order by ID
  static Future<dynamic> getSellerOrderById(int sellerOrderId) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Orders/admin/seller/$sellerOrderId');
    return await _sendGetObjectRequest(url);
  }

  // ----------------------- Helpers -----------------------

  static Future<void> _sendPutRequest(Uri url, String successMessage) async {
    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'PUT',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _logSuccess(successMessage);
      } else {
        await _handleError(response.statusCode, response.body);
      }
    } catch (e) {
      _logException(e);
      rethrow;
    }
  }

  static Future<List<dynamic>> _sendGetListRequest(Uri url) async {
    try {
      final response = await sendAuthorizedRequest(url: url, method: 'GET');

      if (response.statusCode == 200) {
        return _parseJsonList(response.body);
      } else {
        await _handleError(response.statusCode, response.body);
        return [];
      }
    } catch (e) {
      _logException(e);
      rethrow;
    }
  }

  static Future<dynamic> _sendGetObjectRequest(Uri url) async {
    try {
      final response = await sendAuthorizedRequest(url: url, method: 'GET');

      if (response.statusCode == 200) {
        return _parseJsonObject(response.body);
      } else {
        await _handleError(response.statusCode, response.body);
        return null;
      }
    } catch (e) {
      _logException(e);
      rethrow;
    }
  }

  static List<dynamic> _parseJsonList(String jsonStr) {
    try {
      return jsonDecode(jsonStr) as List<dynamic>;
    } catch (e) {
      log('❌ Failed to parse list: $e');
      return [];
    }
  }

  static dynamic _parseJsonObject(String jsonStr) {
    try {
      return jsonDecode(jsonStr);
    } catch (e) {
      log('❌ Failed to parse object: $e');
      return null;
    }
  }

  static Future<void> _handleError(int statusCode, String responseBody) async {
    log('❌ Request failed with status: $statusCode');
    log('Error: $responseBody');

    try {
      final decoded = jsonDecode(responseBody);
      final msg = decoded['description'] ?? decoded['message'] ?? decoded['error'] ?? "Unexpected error";
      throw Exception(msg);
    } catch (_) {
      throw Exception("Server error");
    }
  }

  static void _logSuccess(String message) => log('✅ $message');
  static void _logException(dynamic error) => log('❌ Exception: $error');
}
