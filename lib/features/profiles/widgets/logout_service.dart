import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/taken_storage.dart';

Future<void> revokeRefreshToken() async {
  final accessToken = await TokenStorage.getAccessToken();
  final refreshToken = await TokenStorage.getRefreshToken();

  if (accessToken == null || refreshToken == null) {
    print("No tokens found.");
    return;
  }

  final response = await http.post(
    Uri.parse('http://petsica.runasp.net/Auth/revoke-refresh-token'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'token': accessToken,
      'refreshToken': refreshToken,
    }),
  );

  if (response.statusCode == 200) {
    print("✅ Refresh token revoked successfully.");
  } else {
    print("❌ Failed to revoke refresh token: ${response.body}");
  }
}
