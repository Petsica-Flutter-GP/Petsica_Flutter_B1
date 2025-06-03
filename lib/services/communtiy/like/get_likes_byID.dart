import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:petsica/core/utils/send_Authorized_Request.dart';

  class GetLikesService {
    static Future<List<String>> getLikes(String postId) async {
      final encodedPostId = Uri.encodeComponent(postId);
      final url = Uri.parse('http://petsica.runasp.net/api/Likes/$encodedPostId');
      print('GetLikesService: Fetching likes for postId: $postId');
      print('GetLikesService: Encoded postId: $encodedPostId');
      print('GetLikesService: Full URL: $url');

      try {
        final response = await sendAuthorizedRequest(
          url: url,
          method: 'GET',
          headers: {'Content-Type': 'application/json'},
        );

        print('GetLikesService: Response status: ${response.statusCode}');
        print('GetLikesService: Response body: ${response.body}');

        if (response.statusCode == 200) {
          final List<dynamic> json = jsonDecode(response.body);
          print('GetLikesService: Parsed JSON: $json');
          // Assuming the response is a list of user IDs as strings
          final likes = json.map((id) => id.toString()).toList();
          print('GetLikesService: Fetched ${likes.length} likes for postId: $postId');
          return likes;
        } else {
          print('GetLikesService: Failed to fetch likes, status: ${response.statusCode}, body: ${response.body}');
          return [];
        }
      } catch (e) {
        print('GetLikesService: Error fetching likes: $e');
        return [];
      }
    }
  }