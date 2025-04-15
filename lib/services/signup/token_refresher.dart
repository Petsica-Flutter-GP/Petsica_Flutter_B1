import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/services/signup/auth_response_model.dart';

class TokenRefresher {
  static Future<bool> refreshToken() async {
    final accessToken = await TokenStorage.getAccessToken();
    final refreshToken = await TokenStorage.getRefreshToken();

    if (accessToken == null || refreshToken == null) return false;

    final url = Uri.parse('http://petsica.runasp.net/api/auth/refresh');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'token': accessToken,
        'refreshToken': refreshToken,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final loginResponse = LoginResponse.fromJson(data);

      // حفظ التوكنات الجديدة
      await TokenStorage.saveTokens(
        loginResponse.token,
        loginResponse.refreshToken,
      );

      return true;
    }

    return false;
  }
}
