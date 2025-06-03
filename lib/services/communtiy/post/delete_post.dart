import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';

class DeletePostService {
  static Future<(bool, String?)> deletePost(String postId) async {
    final encodedPostId = Uri.encodeComponent(postId);
    final url = Uri.parse('http://petsica.runasp.net/api/Posts/delete/$encodedPostId');
    print('DeletePostService: Original postId: $postId');
    print('DeletePostService: Encoded postId: $encodedPostId');
    print('DeletePostService: Full URL: $url');

    final body = jsonEncode({'postId': postId});
    print('DeletePostService: Request body: $body');
    print('DeletePostService: Request headers: ${{'Content-Type': 'application/json'}}');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('DeletePostService: Response status: ${response.statusCode}');
      print('DeletePostService: Response body: ${response.body}');
      print('DeletePostService: Response headers: ${response.headers}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('DeletePostService: Successfully deleted post with postId: $postId');
        return (true, null);
      } else {
        String errorMessage;
        try {
          final responseBody = jsonDecode(response.body);
          errorMessage = responseBody['message'] ?? responseBody['error'] ?? 'Failed to delete post';
        } catch (_) {
          errorMessage = 'Failed to delete post: HTTP ${response.statusCode}';
        }
        print('DeletePostService: Failed to delete post, status: ${response.statusCode}, body: ${response.body}');
        return (false, errorMessage);
      }
    } catch (e) {
      print('DeletePostService: Error deleting post: $e');
      return (false, 'Error deleting post: $e');
    }
  }
}