// token_storage.dart
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    await prefs.setString('user_id', userId);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('user_id');
  }

  static Future<void> saveLikeState(String userId, String postId, bool isLiked) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("${userId}_${postId}", isLiked);
  }

  static Future<bool?> getLikeState(String userId, String postId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("${userId}_${postId}");
  }

  static Future<void> clearLikeState(String userId, String postId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("${userId}_${postId}");
  }
}
