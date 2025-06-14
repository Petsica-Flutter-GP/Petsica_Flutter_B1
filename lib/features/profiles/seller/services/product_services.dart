import 'dart:convert';
import 'package:petsica/core/utils/send_Authorized_Request.dart';

// تعريف Enum للفئات
enum ProductCategory { food, toys, accessories, healthcare }

extension ProductCategoryExtension on ProductCategory {
  String get name {
    switch (this) {
      case ProductCategory.food:
        return "Food";
      case ProductCategory.toys:
        return "Toys";
      case ProductCategory.accessories:
        return "Accessories";
      case ProductCategory.healthcare:
        return "Healthcare";
      default:
        return "Food";
    }
  }

  static ProductCategory fromString(String value) {
    switch (value) {
      case 'Food':
        return ProductCategory.food;
      case 'Toys':
        return ProductCategory.toys;
      case 'Accessories':
        return ProductCategory.accessories;
      case 'Healthcare':
        return ProductCategory.healthcare;
      default:
        return ProductCategory.food;
    }
  }
}

class ProductService {
  // إضافة منتج
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
        "Category": category.name
      }),
    );

    return _handleResponse(response);
  }

  // تعديل منتج باستخدام ID في نهاية الرابط (PUT)
// تعديل منتج باستخدام ID في نهاية الرابط (PUT)
  static Future<bool> updateProduct({
    required int productId,
    required String productName,
    required double price,
    required double discount,
    required String description,
    required int quantity,
    required String photo,
    required ProductCategory category,
    required String sellerId,
    required bool isAvailable,
  }) async {
    final url =
        Uri.parse('http://petsica.runasp.net/api/Products/edit/$productId');

    final response = await _sendAuthorizedRequest(
      url: url,
      method: 'PUT',
      body: jsonEncode({
        "ProductName": productName,
        "Price": price,
        "Discount": discount,
        "Description": description,
        "Quantity": quantity,
        "Photo": photo,
        "Category": category.name,
        "sellerId": sellerId,
        "isAvailable": isAvailable,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return _handleResponse(response);
  }

  // جلب منتجات البائع
// جلب منتجات البائع مع القيم المطلوبة
  static Future<List<Product>> getSellerProducts() async {
    final url =
        Uri.parse('http://petsica.runasp.net/api/Products/Seller/products');

    final response = await _sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // تعديل البيانات لتتوافق مع القيم المطلوبة
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // حذف منتج باستخدام ID
  static Future<bool> deleteProduct(int productId) async {
    final url =
        Uri.parse('http://petsica.runasp.net/api/Products/delete/$productId');

    final response = await _sendAuthorizedRequest(
      url: url,
      method: 'POST',
    );

    return _handleResponse(response);
  }

 static Future<bool> markProductAsSoldOut(int productId) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Products/soldout/$productId');

    try {
      final response = await _sendAuthorizedRequest(
        url: url,
        method: 'POST',
      );

      // التحقق من استجابة الـ API
      return _handleResponse(response);
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // دالة إرسال الطلبات مع التوكن
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

  // التحقق من الاستجابة
  static bool _handleResponse(dynamic response) {
    if (response.statusCode == 204 || response.statusCode == 201) {
      return true;
    } else {
      print('Error occurred: ${response.body}');
      return false;
    }
  }
}

// موديل المنتج
class Product {
  final int productId;
  final double price;
  final double discount;
  final String description;
  final int quantity;
  final String productName;
  final String photo;
  final String category;
  final String sellerId;
  late final bool isAvailable;

  Product({
    required this.productId,
    required this.price,
    required this.discount,
    required this.description,
    required this.quantity,
    required this.productName,
    required this.photo,
    required this.category,
    required this.sellerId,
    required this.isAvailable,
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
      sellerId: json['sellerId'],
      isAvailable: json['isAvailable'],
    );
  }
}











/*
import 'dart:convert';
import 'package:petsica/helpers/http_helper.dart';

// تعريف Enum للفئات
enum ProductCategory { food, toys, accessories, healthcare }

extension ProductCategoryExtension on ProductCategory {
  String get name {
    switch (this) {
      case ProductCategory.food:
        return "Food";
      case ProductCategory.toys:
        return "Toys";
      case ProductCategory.accessories:
        return "Accessories";
      case ProductCategory.healthcare:
        return "Healthcare";
      default:
        return "Food";
    }
  }

  static ProductCategory fromString(String value) {
    switch (value) {
      case 'Food':
        return ProductCategory.food;
      case 'Toys':
        return ProductCategory.toys;
      case 'Accessories':
        return ProductCategory.accessories;
      case 'Healthcare':
        return ProductCategory.healthcare;
      default:
        return ProductCategory.food;
    }
  }
}

class ProductService {
  // إضافة منتج
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
        "Category": category.name
      }),
    );

    return _handleResponse(response);
  }

  // تعديل منتج باستخدام ID في نهاية الرابط (PUT)
  static Future<bool> updateProduct({
    required int productId,
    required String productName,
    required double price,
    required double discount,
    required String description,
    required int quantity,
    required String photo,
    required ProductCategory category,
  }) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Products/edit/$productId');

    final response = await _sendAuthorizedRequest(
      url: url,
      method: 'PUT',
      body: jsonEncode({
        "ProductName": productName,
        "Price": price,
        "Discount": discount,
        "Description": description,
        "Quantity": quantity,
        "Photo": photo,
        "Category": category.name
      }),
    );

    return _handleResponse(response);
  }

  // جلب منتجات البائع
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

  // حذف منتج باستخدام ID
  static Future<bool> deleteProduct(int productId) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Products/delete/$productId');

    final response = await _sendAuthorizedRequest(
      url: url,
      method: 'POST',
    );

    return _handleResponse(response);
  }

  // دالة إرسال الطلبات مع التوكن
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

  // التحقق من الاستجابة
  static bool _handleResponse(dynamic response) {
    if (response.statusCode == 204 || response.statusCode == 201) {
      return true;
    } else {
      print('Error occurred: ${response.body}');
      return false;
    }
  }
}

// موديل المنتج
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



*/