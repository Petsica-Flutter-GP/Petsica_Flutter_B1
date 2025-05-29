// services/post_service.dart
import 'dart:convert';
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:http/http.dart' as http;

class PostService {
  static Future<bool> addPost({ required String content, required String imageBase64 }) async {
    final url = Uri.parse('http://petsica.runasp.net/api/posts'); // replace with your real endpoint

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'content': content,"photo":imageBase64}),
    );

    return response.statusCode == 204;
  }
}
