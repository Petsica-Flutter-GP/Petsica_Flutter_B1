import 'dart:convert';
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/core/utils/token_decoder.dart';
import 'package:petsica/services/signup/api_service.dart';
import 'package:petsica/services/signup/refresh_model.dart';
import 'package:petsica/services/signup/refresh_token_request.dart';

class TokenRefresher {
  static Future<bool> refreshToken() async {
    final token = await TokenStorage.getAccessToken();
    final refreshToken = await TokenStorage.getRefreshToken();
    final refreshTokenExpirationStr = await TokenStorage.getRefreshTokenExpiration();

    if (token == null || refreshToken == null || refreshTokenExpirationStr == null) {
      print("Missing tokens or expiration data.");
      return false;
    }

    final refreshTokenExpiration = DateTime.parse(refreshTokenExpirationStr);
    if (DateTime.now().isAfter(refreshTokenExpiration)) {
      print("Refresh token expired. Clearing tokens.");
      await TokenStorage.clearTokens();
      return false;
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
        refreshTokenExpiration: DateTime.now().add(Duration(days: 7)), // Adjust based on server policy
      );
      print("Token refreshed successfully.");
      return true;
    } else {
      print("Refresh token failed: ${response.statusCode} -> ${response.body}");
      if (response.statusCode == 401 || response.statusCode == 403) {
        print("Tokens cleared due to invalid refresh token. Please log in again.");
        await TokenStorage.clearTokens();
      }
      return false;
    }
  }

  static Future<void> checkAndRefreshToken() async {
    final token = await TokenStorage.getAccessToken();
    if (token == null) {
      print("No access token available.");
      return;
    }

    final exp = TokenDecoder.getExpiration(token);
    if (exp == null) {
      print("Failed to parse token expiration.");
      return;
    }

    final now = DateTime.now();
    final fiveMinutes = const Duration(minutes: 5);
    if (exp.difference(now) <= fiveMinutes) {
      print("Token nearing expiration, refreshing...");
      await refreshToken();
    }
  }
}