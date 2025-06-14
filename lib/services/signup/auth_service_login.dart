import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/services/signup/auth_response_model.dart';

class AuthServiceLogin {
  static const String _loginUrl = 'http://petsica.runasp.net/Auth/Login';

  static Future<LoginResponse?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      await TokenStorage.saveTokens(
        accessToken: loginResponse.token,
        refreshToken: loginResponse.refreshToken,
        userId: loginResponse.id,
        refreshTokenExpiration: loginResponse.refreshTokenExpiration,
      );
      return loginResponse;
    } else {
      print('Login failed: ${response.statusCode} -> ${response.body}');
      return null;
    }
  }
}
