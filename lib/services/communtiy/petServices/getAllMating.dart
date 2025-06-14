import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/services/communtiy/petServices/matingResponseModel.dart';

class PetMatingRequest {
  static const String baseUrl = 'http://petsica.runasp.net/api/Pets';
  static String endpoint = 'GetPetMatingList';

  static Future<List<PetMating>> getPetMatingList() async {
    final url = Uri.parse('$baseUrl/$endpoint');
    print('PetMatingRequest: Fetching pet mating list from $url');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
      headers: {'Content-Type': 'application/json'},
    );

    print('PetMatingRequest: Response status: ${response.statusCode}');
    print('PetMatingRequest: Response body: ${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print('PetMatingRequest: Decoded response: $decoded');
      return List<PetMating>.from(decoded.map((json) => PetMating.fromJson(json)));
    } else {
      throw Exception('Failed to fetch pet mating list: ${response.statusCode}');
    }
  }
}