import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';

class AddCommentService {
  static Future<(bool, String?)> addComment(String postId, String content) async {
    final encodedPostId = Uri.encodeComponent(postId);
    final url = Uri.parse('http://petsica.runasp.net/api/Comments/$encodedPostId');
    print('AddCommentService: Adding comment to postId: $postId');
    print('AddCommentService: Full URL: $url');
    print('AddCommentService: Request method: POST');
    print('AddCommentService: Request body: {"content": "$content"}');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'content': content}),
      );

      print('AddCommentService: Response status: ${response.statusCode}');
      print('AddCommentService: Response body: ${response.body}');

      if (response.statusCode == 204) {
        print('AddCommentService: Successfully added comment to postId: $postId');
        return (true, null);
      } else {
        String errorMessage;
        try {
          final responseBody = jsonDecode(response.body);
          errorMessage = responseBody['message'] ?? responseBody['error'] ?? 'Failed to add comment';
        } catch (_) {
          errorMessage = 'Failed to add comment: HTTP ${response.statusCode}';
        }
        print('AddCommentService: Failed to add comment, status: ${response.statusCode}, body: ${response.body}');
        return (false, errorMessage);
      }
    } catch (e) {
      print('AddCommentService: Error adding comment: $e');
      return (false, 'Error adding comment: $e');
    }
  }
}