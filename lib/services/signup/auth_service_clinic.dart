import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServiceClinic {
  static const String _baseUrl = "http://petsica.runasp.net/Auth/registerClinic";

  static Future<Map<String, dynamic>> registerClinic({
    required String userName,
    required String email,
    required String password,
    required String address,
    required String workingHours,
    required String phone,
    required String verificationImageBase64,
    required String profileImageBase64,
  }) async {
    try {
      final body = jsonEncode({
        "userName": userName,
        "email": email,
        "password": password,
        "photo": profileImageBase64,
        "address": address,
        "type": "CLINIC",
        "approvalPhoto": verificationImageBase64,
        "nationalID": "string",
        "workingHours": workingHours,
        "contactInfo": phone,
      });

      print("⏩ Request body: $body");

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print("🔁 Status: ${response.statusCode}");
      print("📩 Body: ${response.body}");

      if (response.statusCode == 204) {
        return {"success": true, "message": "Registration successful"};
      } else {
        final Map<String, dynamic> responseData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {};
        return {
          "success": false,
          "message": responseData["message"] ??
              responseData["error"] ??
              "Registration failed",
        };
      }
    } catch (e) {
      return {"success": false, "message": "Network error: $e"};
    }
  }
}