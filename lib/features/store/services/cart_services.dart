import 'dart:convert';
import 'package:petsica/core/utils/send_Authorized_Request.dart';

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
}
