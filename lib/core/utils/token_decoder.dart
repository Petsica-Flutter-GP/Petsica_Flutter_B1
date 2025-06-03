import 'dart:convert';

class TokenDecoder {
  static Map<String, dynamic> decodeToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = base64Url.normalize(parts[1]);
    final decoded = utf8.decode(base64Url.decode(payload));
    return jsonDecode(decoded);
  }

  static List<String> getRoles(String token) {
    final decoded = decodeToken(token);
    return List<String>.from(decoded['roles'] ?? []);
  }

  static String? getUserId(String token) {
    final decoded = decodeToken(token);
    return decoded['sub'];
  }

  static DateTime? getExpiration(String token) {
    final decoded = decodeToken(token);
    final exp = decoded['exp'] as int?;
    return exp != null ? DateTime.fromMillisecondsSinceEpoch(exp * 1000) : null;
  }
}