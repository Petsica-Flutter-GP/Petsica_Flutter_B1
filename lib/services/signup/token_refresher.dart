import 'dart:convert';
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/services/signup/api_service.dart';
import 'package:petsica/services/signup/auth_response_model.dart';

import 'package:petsica/services/signup/refresh_token_request.dart';


class TokenRefresher {
  static Future<bool> refreshToken() async {
    final token = await TokenStorage.getAccessToken();
    final refreshToken = await TokenStorage.getRefreshToken();

    if (token == null || refreshToken == null) return false;


    final request = RefreshTokenRequest(token: token, refreshToken: refreshToken);

    final url = Uri.parse('http://petsica.runasp.net/api/auth/refresh');


    final response = await ApiService.post(
      'http://petsica.runasp.net/Auth/Refresh',
      request.toJson(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final loginResponse = LoginResponse.fromJson(data);

      // حفظ التوكنات الجديدة
      await TokenStorage.saveTokens(
        accessToken: loginResponse.token,
        refreshToken: loginResponse.refreshToken,
      );

      return true;
    } else {
      print("Refresh token failed: ${response.statusCode} -> ${response.body}");
      return false;
    }
  }
}
