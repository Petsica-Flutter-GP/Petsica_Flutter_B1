import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/services/communtiy/comment/comment_response_model.dart';

class GetCommentsService {
  static Future<List<Comment>> getComments(String postId) async {
    final encodedPostId = Uri.encodeComponent(postId);
    final url = Uri.parse('http://petsica.runasp.net/api/Comments/$encodedPostId');
    print('GetCommentsService: Fetching comments for postId: $postId');
    print('GetCommentsService: Full URL: $url');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'GET',
        headers: {'Content-Type': 'application/json'},
      );

      print('GetCommentsService: Response status: ${response.statusCode}');
      print('GetCommentsService: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        print('GetCommentsService: Decoded JSON data: $jsonData');
        final comments = jsonData.map((json) => Comment.fromJson(json)).toList();
        print('GetCommentsService: Parsed comments: $comments');
        return comments;
      } else {
        throw Exception('Failed to fetch comments: HTTP ${response.statusCode}');
      }
    } catch (e) {
      print('GetCommentsService: Error fetching comments: $e');
      throw Exception('Error fetching comments: $e');
    }
  }
}