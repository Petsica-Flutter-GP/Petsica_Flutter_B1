// token_refresher.dart
import 'dart:convert';
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/core/utils/token_decoder.dart';
import 'package:petsica/services/signup/api_service.dart';
import 'package:petsica/services/signup/auth_response_model.dart';
import 'package:petsica/services/signup/refresh_model.dart';
import 'package:petsica/services/signup/refresh_token_request.dart';

class TokenRefresher {
  static Future<bool> refreshToken() async {
    final token = await TokenStorage.getAccessToken();
    final refreshToken = await TokenStorage.getRefreshToken();

    if (token == null || refreshToken == null) {
      return false; // Don't clear tokens to allow retry
    }

    final request = RefreshTokenRequest(token: token, refreshToken: refreshToken);

    final response = await ApiService.post(
      'http://petsica.runasp.net/api/Auth/refresh',
      request.toJson(),
    );

    if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  final refreshResponse = RefreshResponse.fromJson(data);

  await TokenStorage.saveTokens(
    accessToken: refreshResponse.token,
    refreshToken: refreshResponse.refreshToken,
    userId: await TokenStorage.getUserId() ?? '',
  );
  return true;
}
 else {
      print("Refresh token failed: ${response.statusCode} -> ${response.body}");
      return false; // Don't clear tokens unless logout
    }
  }

  static Future<void> checkAndRefreshToken() async {
    final token = await TokenStorage.getAccessToken();
    if (token == null) return;

    final exp = TokenDecoder.getExpiration(token);
    if (exp == null) return;

    final now = DateTime.now();
    final fiveMinutes = const Duration(minutes: 5);
    if (exp.difference(now) <= fiveMinutes) {
      await refreshToken();
    }
  }
}
