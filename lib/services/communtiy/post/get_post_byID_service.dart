import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/services/communtiy/post/get_all_posts_model.dart';

class GetPostService {
  static Future<Post?> getPost(String postId) async {
    final encodedPostId = Uri.encodeComponent(postId);
    final url = Uri.parse('http://petsica.runasp.net/api/Posts/$encodedPostId');
    print('GetPostService: Fetching post with postId: $postId');
    print('GetPostService: Encoded postId: $encodedPostId');
    print('GetPostService: Full URL: $url');
    print('GetPostService: Request method: GET');
    print('GetPostService: Request headers: ${{'Content-Type': 'application/json'}}');

    try {
      final response = await sendAuthorizedRequest(
        url: url,
        method: 'GET',
        headers: {'Content-Type': 'application/json'},
      );

      print('GetPostService: Response status: ${response.statusCode}');
      print('GetPostService: Response body: ${response.body}');
      print('GetPostService: Response headers: ${response.headers}');

      if (response.statusCode == 200) {
        try {
          final json = jsonDecode(response.body);
          print('GetPostService: Parsed JSON: $json');
          final post = Post.fromJson(json);
          print('GetPostService: Successfully fetched post: $post');
          return post;
        } catch (e) {
          print('GetPostService: Error parsing response body: $e');
          // Fallback: If parsing fails, return a minimal Post with just the postId
          return Post(
            postId: postId,
            content: '',
            userId: '',
            username: null,
            photoBase64: null,
            likesCount: 0,
            commentCount: 0,
          );
        }
      } else {
        print('GetPostService: Failed to fetch post, status: ${response.statusCode}, body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('GetPostService: Error fetching post: $e');
      return null;
    }
  }
}