import 'dart:convert';
import 'dart:developer';

import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/store/models/cart_model.dart';

import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/store/models/cart_model.dart';

class CartService {
  /// ✅ إضافة منتج إلى السلة
  static Future<void> addToCart({
    required int productId,
    required int quantity,
  }) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Carts/add');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'POST',
      body: jsonEncode({
        "productId": productId,
        "quantity": quantity,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('فشل في إضافة المنتج إلى السلة: ${response.statusCode}');
    }
  }

  static Future<void> updateCartItem({
    required int productId,
    required int quantity,
  }) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Carts/update');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'PUT',
        body: jsonEncode({
          "productId": productId,
          "quantity": quantity,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // طباعة response body في حالة نجاح الطلب
      log('@@@@@@Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Updated Successfuly ${response.statusCode}');
      }
    } catch (e) {
      // طباعة الاستثناء في حالة حدوث أي خطأ
      print('Error: $e');
      rethrow; // لإعادة رمي الاستثناء علشان يتعامل معه في الكيوبت
    }
  }

  /// ✅ جلب كل عناصر السلة
  static Future<CartResponseModel> getCartItems() async {
    final url = Uri.parse('http://petsica.runasp.net/api/Carts/items');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return CartResponseModel.fromJson(decoded);
    } else {
      throw Exception('فشل في جلب بيانات السلة: ${response.statusCode}');
    }
  }





  /// ✅ حذف منتج من السلة
static Future<void> deleteCartItem({
  required int productId,
}) async {
  final url = Uri.parse('http://petsica.runasp.net/api/Carts/remove/$productId');

  try {
    final response = await sendAuthorizedRequest(
      url: url,
      method: 'DELETE',
    );

    if (response.statusCode == 200) {
      log('🗑️ Deleted sucessfuly');
      return;
    } else {
      throw Exception('Error:: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during deleteCartItem: $e');
    rethrow;
  }
}

}
