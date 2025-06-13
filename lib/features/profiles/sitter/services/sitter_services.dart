import 'dart:convert';
import 'dart:developer';

import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/profiles/sitter/models/sitter_services_model.dart';

class SitterService {
  static Future<void> addSitterService({
    required double price,
    required String description,
    required String title,
    required String location,
  }) async {
    final url = Uri.parse('http://petsica.runasp.net/me/AddSitterService');

    final body = jsonEncode({
      "price": price,
      "description": description,
      "title": title,
      "location": location,
    });

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'POST',
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 204) {
      log("✅ Sitter service added successfully");
    } else {
      throw Exception("❌ Failed to add sitter service: ${response.statusCode}");
    }
  }


// ✅ Get sitter services
  static Future<List<SitterServiceModel>> getMyServices() async {
    final url = Uri.parse('http://petsica.runasp.net/me/AllService');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList.map((json) => SitterServiceModel.fromJson(json)).toList();
    } else {
      throw Exception("❌ Failed to fetch services: ${response.statusCode}");
    }
  }


}
