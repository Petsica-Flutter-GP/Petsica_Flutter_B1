import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';

class LikeDislikeService {
  static Future<(bool success, String? errorMessage)> likePost(String postId) async {
    final encodedPostId = Uri.encodeComponent(postId);
    final url = Uri.parse('http://petsica.runasp.net/api/Likes/$encodedPostId');
    print('LikeDislikeService: Sending like request for postId: $postId');
    print('LikeDislikeService: Encoded postId: $encodedPostId');
    print('LikeDislikeService: Full URL: $url');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
      );

      print('LikeDislikeService: Like response status: ${response.statusCode}');
      print('LikeDislikeService: Like response body: ${response.body}');
      print('LikeDislikeService: Like response headers: ${response.headers}');

      if (response.statusCode == 204) {
        return (true, null);
      } else {
        return (false, 'Failed to like post: HTTP ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      print('LikeDislikeService: Error liking post: $e');
      return (false, 'Error liking post: $e');
    }
  }

  static Future<(bool success, String? errorMessage)> dislikePost(String postId) async {
    final encodedPostId = Uri.encodeComponent(postId);
    final url = Uri.parse('http://petsica.runasp.net/api/Likes/$encodedPostId');
    print('LikeDislikeService: Sending dislike request for postId: $postId');
    print('LikeDislikeService: Encoded postId: $encodedPostId');
    print('LikeDislikeService: Full URL: $url');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'DELETE',
        headers: {'Content-Type': 'application/json'},
      );

      print('LikeDislikeService: Dislike response status: ${response.statusCode}');
      print('LikeDislikeService: Dislike response body: ${response.body}');
      print('LikeDislikeService: Dislike response headers: ${response.headers}');

      if (response.statusCode == 200) {
        return (true, null);
      } else {
        return (false, 'Failed to dislike post: HTTP ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      print('LikeDislikeService: Error disliking post: $e');
      return (false, 'Error disliking post: $e');
    }
  }
}