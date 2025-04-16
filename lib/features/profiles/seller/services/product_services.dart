// import 'dart:convert';
// import 'package:petsica/helpers/http_helper.dart';

// class ProductService {
//   static Future<bool> addProduct({
//     required String productName,
//     required double price,
//     required double discount,
//     required String description,
//     required int quantity,
//     required String photo,
//     required String category,
//   }) async {
//     final url = Uri.parse('http://petsica.runasp.net/api/Products/addProduct');

//     final response = await sendAuthorizedRequest(
//       url: url,
//       method: 'POST',
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         "ProductName": productName,
//         "Price": price,
//         "Discount": discount,
//         "Description": description,
//         "Quantity": quantity,
//         "Photo": photo,
//         "Category": category
//       }),
//     );

//     // طباعة الاستجابة في الـ terminal
//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');

//     if (response.statusCode == 204 || response.statusCode == 201) {
//       return true; // النجاح
//     } else {
//       // إظهار رسالة الخطأ في الـ terminal
//       print('Error occurred: ${response.body}');
//       return false; // الفشل
//     }
//   }

//   static Future<List<Product>> getSellerProducts() async {
//     final url =
//         Uri.parse('http://petsica.runasp.net/api/Products/Seller/products');

//     // إرسال الطلب مع التوكن
//     final response = await sendAuthorizedRequest(
//       url: url,
//       method: 'GET',
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);

//       // تحويل البيانات إلى قائمة من المنتجات
//       return data.map((json) => Product.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
// }

// class Product {
//   final int productId;
//   final double price;
//   final double discount;
//   final String description;
//   final int quantity;
//   final String productName;
//   final String photo;
//   final String category;

//   Product({
//     required this.productId,
//     required this.price,
//     required this.discount,
//     required this.description,
//     required this.quantity,
//     required this.productName,
//     required this.photo,
//     required this.category,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       productId: json['productId'],
//       price: json['price'],
//       discount: json['discount'],
//       description: json['description'],
//       quantity: json['quantity'],
//       productName: json['productName'],
//       photo: json['photo'],
//       category: json['category'],
//     );
//   }
// }

import 'dart:convert';
import 'package:petsica/helpers/http_helper.dart';

// تعريف Enum للفئات
enum ProductCategory { food, healthcare, accessories }

class ProductService {
  static Future<bool> addProduct({
    required String productName,
    required double price,
    required double discount,
    required String description,
    required int quantity,
    required String photo,
    required ProductCategory category,
  }) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Products/addProduct');

    final response = await _sendAuthorizedRequest(
      url: url,
      method: 'POST',
      body: jsonEncode({
        "ProductName": productName,
        "Price": price,
        "Discount": discount,
        "Description": description,
        "Quantity": quantity,
        "Photo": photo,
        "Category": category.name // استخدام Enum بدلاً من String
      }),
    );

    return _handleResponse(response);
  }

  static Future<List<Product>> getSellerProducts() async {
    final url = Uri.parse('http://petsica.runasp.net/api/Products/Seller/products');

    final response = await _sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // دالة مشتركة لإرسال الطلبات المصرح بها
  static Future<dynamic> _sendAuthorizedRequest({
    required Uri url,
    required String method,
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await sendAuthorizedRequest(
      url: url,
      method: method,
      headers: headers ?? {'Content-Type': 'application/json'},
      body: body,
    );
    return response;
  }

  // التعامل مع الاستجابة
  static bool _handleResponse(dynamic response) {
    if (response.statusCode == 204 || response.statusCode == 201) {
      return true; // نجاح العملية
    } else {
      print('Error occurred: ${response.body}');
      return false; // فشل العملية
    }
  }
}

class Product {
  final int productId;
  final double price;
  final double discount;
  final String description;
  final int quantity;
  final String productName;
  final String photo;
  final String category;

  Product({
    required this.productId,
    required this.price,
    required this.discount,
    required this.description,
    required this.quantity,
    required this.productName,
    required this.photo,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      price: json['price'],
      discount: json['discount'],
      description: json['description'],
      quantity: json['quantity'],
      productName: json['productName'],
      photo: json['photo'],
      category: json['category'],
    );
  }
}

