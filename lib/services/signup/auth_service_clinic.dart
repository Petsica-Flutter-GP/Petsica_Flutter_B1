import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServiceClinic {
  static const String _baseUrl = "http://petsica.runasp.net/Auth/registerUser";

  static Future<Map<String, dynamic>> registerClinic({
    required String userName,
    required String email,
    required String password,
    required String address,
    required String workingHours,
    required String phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
            "userName": userName,
            "email": email,
            "password": password,
            "photo": "string",
            "address": address,
            "approvalPhoto": "string",
            "type": "CLINIC",
            "workingHours": workingHours,
            "contactInfo": phone,
            "nationalID": "string"
        }),
      );

      if (response.statusCode == 204) {
        return {"success": true, "message": "Registration successful"};
      } else {
        final Map<String, dynamic> responseData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {}; // Handle empty response

        return {
          "success": false,
          "message": responseData["message"] ??
              responseData["error"] ??
              "Registeration failed"
        };
      }
    } catch (e) {
      return {"success": false, "message": "Network error: $e"};
    }
  }
}
