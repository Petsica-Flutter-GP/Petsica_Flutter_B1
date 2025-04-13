// services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/services/signup/auth_response_model.dart';

class AuthService {
  static const String _loginUrl = 'http://petsica.runasp.net/Auth/Login'; // Replace with your actual endpoint

  static Future<LoginResponse?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      print('Login failed: ${response.body}');
      return null;
    }
  }
}
