import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServiceSeller {
  static const String _baseUrl = "http://petsica.runasp.net/Auth/registerUser";

  static Future<Map<String, dynamic>> registerSeller({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "UserName": userName,
          "Email": email,
          "Password": password,
          "Photo": "photo", 
          "Address": "fayoum", 
          "Type": "SELLER",
          "ApprovalPhoto": "string", 
          "NationalID": "NationalID" 
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
