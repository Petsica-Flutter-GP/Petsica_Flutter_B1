import 'dart:convert';
import 'dart:developer';

import 'package:petsica/core/utils/send_Authorized_Request.dart';

class AdminServices {
  // Cancel order by admin
  static Future<void> cancelOrderByAdmin(int orderID) async {
    final url =
        Uri.parse('http://petsica.runasp.net/api/Orders/admin/cancel/$orderID');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'PUT',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _logSuccess('Order #$orderID canceled successfully by admin.');
      } else {
        await _handleError(response.statusCode, response.body);
      }
    } catch (error) {
      _logException(error);
      rethrow;
    }
  }

// Make order complete by admin
  static Future<void> completeOrderByAdmin(int orderID) async {
    final url = Uri.parse(
        'http://petsica.runasp.net/api/Orders/admin/complete/$orderID');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'PUT',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _logSuccess('Order #$orderID marked as complete by admin.');
      } else {
        await _handleError(response.statusCode, response.body);
      }
    } catch (error) {
      _logException(error);
      rethrow;
    }
  }

  // Get all orders by admin
  static Future<List<dynamic>> getAllOrdersByAdmin() async {
    final url = Uri.parse('http://petsica.runasp.net/api/Orders/all');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'GET',
      );

      if (response.statusCode == 200) {
        final data = response.body; // Assuming response.body is JSON string
        return _parseJsonList(data);
      } else {
        await _handleError(response.statusCode, response.body);
        return [];
      }
    } catch (error) {
      _logException(error);
      rethrow;
    }
  }

  // Get all seller orders by admin
  static Future<List<dynamic>> getAllSellerOrdersByAdmin() async {
    final url =
        Uri.parse('http://petsica.runasp.net/api/Orders/all/sellerorders');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'GET',
      );

      if (response.statusCode == 200) {
        final data = response.body;
        return _parseJsonList(data);
      } else {
        await _handleError(response.statusCode, response.body);
        return [];
      }
    } catch (error) {
      _logException(error);
      rethrow;
    }
  }

  // Get seller order by ID by admin
  static Future<dynamic> getSellerOrderById(int sellerOrderId) async {
    final url = Uri.parse(
        'http://petsica.runasp.net/api/Orders/admin/seller/$sellerOrderId');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'GET',
      );

      if (response.statusCode == 200) {
        final data = response.body;
        return _parseJsonObject(data);
      } else {
        await _handleError(response.statusCode, response.body);
        return null;
      }
    } catch (error) {
      _logException(error);
      rethrow;
    }
  }

  // Get order by ID by admin
  static Future<dynamic> getOrderById(int orderID) async {
    final url =
        Uri.parse('http://petsica.runasp.net/api/Orders/admin/$orderID');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'GET',
      );

      if (response.statusCode == 200) {
        final data = response.body;
        return _parseJsonObject(data);
      } else {
        await _handleError(response.statusCode, response.body);
        return null;
      }
    } catch (error) {
      _logException(error);
      rethrow;
    }
  }

  // --- Helpers ---

  static void _logSuccess(String message) {
    print('✅ $message');
  }

  // static Future<void> _handleError(int statusCode, String responseBody) async {
  //   log('❌ Request failed with status code: $statusCode');
  //   log('Error details: $responseBody');

  //   try {
  //     final decoded = jsonDecode(responseBody);

  //     final description = decoded['description'] ??
  //         decoded['message'] ??
  //         decoded['error'] ??
  //         responseBody;

  //     throw Exception(description);
  //   } catch (e) {
  //     throw Exception(responseBody);
  //   }
  // }


static Future<void> _handleError(int statusCode, String responseBody) async {
  log('❌ Request failed with status code: $statusCode');
  log('Error details: $responseBody');

  try {
    final decoded = jsonDecode(responseBody);

    final description = decoded['description'] ??
        decoded['message'] ??
        decoded['error'] ??
        "Unexpected error";

    throw Exception(description); // رسالة نصية مباشرة
  } catch (e) {
    throw Exception("Server error");
  }
}

  static void _logException(dynamic error) {
    print('❌ Exception occurred: $error');
  }

  // Parse a JSON list string to dynamic list
  static List<dynamic> _parseJsonList(String jsonString) {
    try {
      return jsonDecode(jsonString) as List<dynamic>;
    } catch (e) {
      print('❌ Failed to parse JSON list: $e');
      return [];
    }
  }

  // Parse a JSON object string to dynamic map
  static dynamic _parseJsonObject(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      print('❌ Failed to parse JSON object: $e');
      return null;
    }
  }
}
