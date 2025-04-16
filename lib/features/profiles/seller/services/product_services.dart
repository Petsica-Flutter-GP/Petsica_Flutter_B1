import 'dart:convert';
import 'package:petsica/helpers/http_helper.dart';

class ProductService {
  static Future<bool> addProduct({
    required String productName,
    required double price,
    required double discount,
    required String description,
    required int quantity,
    required String photo,
    required String category,
  }) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Products/addProduct');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": productName,
        "Price": price,
        "Discount": discount,
        "Description": description,
        "Quantity": quantity,
        "Photo": photo,
        "Category": category
      }),
    );

    // طباعة الاستجابة في الـ terminal
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 204 || response.statusCode == 201) {
      return true; // النجاح
    } else {
      // إظهار رسالة الخطأ في الـ terminal
      print('Error occurred: ${response.body}');
      return false; // الفشل
    }
  }
}
