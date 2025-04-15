import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> post(String url, Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
  }
}
