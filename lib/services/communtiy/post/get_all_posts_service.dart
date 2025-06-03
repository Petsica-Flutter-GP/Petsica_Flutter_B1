import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';

class GetPostsService {
  static Future<List<Map<String, dynamic>>> getAllPosts() async {
    final url = Uri.parse('http://petsica.runasp.net/api/posts');
    print('GetPostsService: Fetching posts from $url');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
      headers: {'Content-Type': 'application/json'},
    );

    print('GetPostsService: Response status: ${response.statusCode}');
    print('GetPostsService: Response body: ${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print('GetPostsService: Decoded response: $decoded');
      return List<Map<String, dynamic>>.from(decoded);
    } else {
      throw Exception('Failed to fetch posts: ${response.statusCode}');
    }
  }
}