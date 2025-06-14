import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/services/communtiy/petServices/sitterResponseModel.dart';

class PetSitterRequest {
  static const String baseUrl = 'http://petsica.runasp.net/me';
  static String endpoint = 'AllService';

  static Future<List<PetSitter>> getPetSitterServices() async {
    final url = Uri.parse('$baseUrl/$endpoint');
    print('PetSitterRequest: Fetching pet sitter services from $url');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
      headers: {'Content-Type': 'application/json'},
    );

    print('PetSitterRequest: Response status: ${response.statusCode}');
    print('PetSitterRequest: Response headers: ${response.headers}');
    print('PetSitterRequest: Response body: ${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print('PetSitterRequest: Decoded response: $decoded');
      return List<PetSitter>.from(decoded.map((json) => PetSitter.fromJson(json)));
    } else {
      throw Exception('Failed to fetch pet sitter services: ${response.statusCode} - ${response.body}');
    }
  }
}