import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = "http://petsica.runasp.net/Auth/registerSitter";

  static Future<Map<String, dynamic>> registerSitter({
    required String userName,
    required String email,
    required String phone,
    required String nationalId,
    required String location,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userName": userName,
          "email": email,
          "phone": phone,
          "nationalID": nationalId,
          "location": location,
          "password": password,
          "photo": "photo_placeholder", // Optional placeholder
          "address": location, // Using location as address
        }),
      );

      if (response.statusCode == 204) {
        return {"success": true, "message": "Registration successful"};
      } else {
        final Map<String, dynamic> responseData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {};

        return {
          "success": false,
          "message": responseData["message"] ?? responseData["error"] ?? "Registration failed"
        };
      }
    } catch (e) {
      return {"success": false, "message": "Network error: $e"};
    }
  }
}