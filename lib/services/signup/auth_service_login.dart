// services/auth_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:petsica/services/signup/auth_response_model.dart';

class AuthService {
  static const String _loginUrl =
      'http://petsica.runasp.net/Auth/Login'; // استبدلي برابطك الفعلي

  static Future<LoginResponse?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json', // إضافة رأس للقبول
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      // إذا كان الرد 307 (إعادة توجيه مؤقتة)
      if (response.statusCode == 307) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          log('Redirecting to: $redirectUrl');

          // إرسال الطلب مرة أخرى إلى الرابط الجديد
          final followResponse = await http.post(
            Uri.parse(redirectUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({'email': email, 'password': password}),
          );

          if (followResponse.statusCode == 200) {
            return LoginResponse.fromJson(jsonDecode(followResponse.body));
          } else {
            log('Redirected login failed: ${followResponse.body}');
            log('Redirected Status Code: ${followResponse.statusCode}');
            return null;
          }
        } else {
          log('Redirect location not found');
          return null;
        }
      }

      // إذا كان الرد 200 (نجاح)
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        log('Login failed: ${response.body}');
        log('Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error during login: $e');
      return null;
    }
  }
}
