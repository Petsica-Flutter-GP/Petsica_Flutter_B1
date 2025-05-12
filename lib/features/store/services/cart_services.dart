import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/store/models/cart_model.dart';

import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/store/models/cart_model.dart';
import 'package:petsica/features/store/services/store_services.dart';

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

  //   /// ✅ تحديث كمية المنتج في السلة
  // static Future<void> updateCartItem({
  //   required int productId,
  //   required int quantity,
  // }) async {
  //   try {
  //     // ✅ جلب بيانات المنتج للتحقق من الكمية المتاحة
  //     final product = await StoreService.getProductByID(productId);

  //     // ✅ التحقق من أن الكمية المطلوبة أقل من الكمية المتاحة
  //     if (quantity > product.quantity) {
  //       throw Exception(
  //           'لا يمكن طلب كمية أكبر من المتاحة: ${product.quantity}');
  //     }

  //     final url = Uri.parse('http://petsica.runasp.net/api/Carts/update');

  //     final response = await sendAuthorizedRequest(
  //       url: url,
  //       method: 'PUT',
  //       body: jsonEncode({
  //         "productId": productId,
  //         "quantity": quantity,
  //       }),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     // طباعة response body في حالة نجاح الطلب
  //     log('@@@@@@Response Body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       return;
  //     } else {
  //       throw Exception('فشل في تحديث المنتج: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // طباعة الاستثناء في حالة حدوث أي خطأ
  //     print('Error: $e');
  //     rethrow; // لإعادة رمي الاستثناء
  //   }
  // }

/// ✅ تحديث كمية المنتج في السلة
static Future<http.Response> updateCartItem({
  required int productId,
  required int quantity,
}) async {
  try {
    // ✅ جلب بيانات المنتج للتحقق من الكمية المتاحة
    final product = await StoreService.getProductByID(productId);

    // ✅ التحقق من أن الكمية المطلوبة أقل من الكمية المتاحة
    if (quantity > product.quantity) {
      throw Exception(
          'لا يمكن طلب كمية أكبر من المتاحة: ${product.quantity}');
    }

    final url = Uri.parse('http://petsica.runasp.net/api/Carts/update');

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
      return response; // إرجاع الاستجابة في حال نجاح التحديث
    } else {
      throw Exception('فشل في تحديث المنتج: ${response.statusCode}');
    }
  } catch (e) {
    // طباعة الاستثناء في حالة حدوث أي خطأ
    print('Error: $e');
    rethrow; // لإعادة رمي الاستثناء
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
