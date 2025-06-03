import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';

class DeleteCommentService {
  static Future<(bool, String?)> deleteComment(String commentId) async {
    final encodedCommentId = Uri.encodeComponent(commentId);
    final url = Uri.parse('http://petsica.runasp.net/api/Comments/delete/$encodedCommentId');
    print('DeleteCommentService: Original commentId: $commentId');
    print('DeleteCommentService: Encoded commentId: $encodedCommentId');
    print('DeleteCommentService: Full URL: $url');

    final body = jsonEncode({'CommentId': commentId});
    print('DeleteCommentService: Request body: $body');
    print('DeleteCommentService: Request headers: ${{'Content-Type': 'application/json'}}');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('DeleteCommentService: Response status: ${response.statusCode}');
      print('DeleteCommentService: Response body: ${response.body}');
      print('DeleteCommentService: Response headers: ${response.headers}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('DeleteCommentService: Successfully deleted comment with commentId: $commentId');
        return (true, null);
      } else {
        String errorMessage;
        try {
          final responseBody = jsonDecode(response.body);
          errorMessage = responseBody['message'] ?? responseBody['error'] ?? 'Failed to delete comment';
        } catch (_) {
          errorMessage = 'Failed to delete comment: HTTP ${response.statusCode}';
        }
        print('DeleteCommentService: Failed to delete comment, status: ${response.statusCode}, body: ${response.body}');
        return (false, errorMessage);
      }
    } catch (e) {
      print('DeleteCommentService: Error deleting comment: $e');
      return (false, 'Error deleting comment: $e');
    }
  }
}