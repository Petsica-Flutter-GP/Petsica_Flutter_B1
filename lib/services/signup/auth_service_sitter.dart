import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServiceSitter {
  static const String _baseUrl = "http://petsica.runasp.net/Auth/registerUser";

  static Future<Map<String, dynamic>> registerSitter({
    required String userName,
    required String email,
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
          "password": password,
          "photo": "photo", // Optional (Replace with real data)
          "address": location, // Optional
          "type": "SITTER",
          "approvalPhoto": "string", // Optional
          "nationalID": "nationalId" // Using location as address
        }),
      );

      if (response.statusCode == 204) {
        return {"success": true, "message": "Registration successful"};
      } else {
        final Map<String, dynamic> responseData =
            response.body.isNotEmpty ? jsonDecode(response.body) : {};

        return {
          "success": false,
          "message": responseData["message"] ??
              responseData["error"] ??
              "Registration failed"
        };
      }
    } catch (e) {
      return {"success": false, "message": "Network error: $e"};
    }
  }
}