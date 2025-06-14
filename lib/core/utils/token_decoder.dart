import 'dart:convert';

class TokenDecoder {
  static DateTime? getExpiration(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        print("Invalid JWT format");
        return null;
      }

      final payload = parts[1];
      final normalizedPayload = base64Url.normalize(payload);
      final decodedBytes = base64Url.decode(normalizedPayload);
      final decodedString = utf8.decode(decodedBytes);
      final payloadMap = jsonDecode(decodedString) as Map<String, dynamic>;

      final exp = payloadMap['exp'] as int?;
      if (exp == null) {
        print("No 'exp' claim in token");
        return null;
      }

      return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    } catch (e) {
      print("Error decoding token: $e");
      return null;
    }
  }

  static List<String> getRoles(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        print("Invalid JWT format");
        return [];
      }

      final payload = parts[1];
      final normalizedPayload = base64Url.normalize(payload);
      final decodedBytes = base64Url.decode(normalizedPayload);
      final decodedString = utf8.decode(decodedBytes);
      final payloadMap = jsonDecode(decodedString) as Map<String, dynamic>;

      final roles = payloadMap['roles'] ?? payloadMap['role'] ?? [];
      if (roles is List) {
        return List<String>.from(roles);
      } else if (roles is String) {
        return [roles];
      }
      print("No valid roles found in token");
      return [];
    } catch (e) {
      print("Error decoding roles from token: $e");
      return [];
    }
  }

  static String? getUserId(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        print("Invalid JWT format");
        return null;
      }

      final payload = parts[1];
      final normalizedPayload = base64Url.normalize(payload);
      final decodedBytes = base64Url.decode(normalizedPayload);
      final decodedString = utf8.decode(decodedBytes);
      final payloadMap = jsonDecode(decodedString) as Map<String, dynamic>;

      final userId = payloadMap['sub'] ?? payloadMap['userId'] ?? payloadMap['id'];
      if (userId is String) {
        return userId;
      }
      print("No valid user ID found in token");
      return null;
    } catch (e) {
      print("Error decoding user ID from token: $e");
      return null;
    }
  }
}