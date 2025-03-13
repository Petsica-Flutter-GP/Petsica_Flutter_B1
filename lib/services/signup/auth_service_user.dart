import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = "http://petsica.runasp.net/Auth/register";

  static Future<Map<String, dynamic>> registerUser({
    required String userName,
    required String email,
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
          "address": "fayoum", // Optional
          "location": "fayuoooooom", // Optional
          "nationalID": "14578953" // Example (Should be real data)
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
              "This account is already signed up"
        };
      }
    } catch (e) {
      return {"success": false, "message": "Network error: $e"};
    }
  }
}