import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';

class StoreService {

  static Future<List<Product>> getAll() async {
    final url = Uri.parse('http://petsica.runasp.net/api/Products');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('failed to load ${response.statusCode}');
    }
  }


static Future<List<Product>> getByCategory(String category) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Products/$category');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('فشل في تحميل المنتجات من فئة $category: ${response.statusCode}');
    }
  }



}
