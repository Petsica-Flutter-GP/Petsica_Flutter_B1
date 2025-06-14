import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/services/communtiy/petServices/adoptionResponseModel.dart';

class PetAdoptionRequest {
  static const String baseUrl = 'http://petsica.runasp.net/api/Pets';
  static String endpoint = 'GetPetAdoptionList';

  static Future<List<PetAdoption>> getPetAdoptionList() async {
    final url = Uri.parse('$baseUrl/$endpoint');
    print('PetAdoptionRequest: Fetching pet adoption list from $url');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
      headers: {'Content-Type': 'application/json'},
    );

    print('PetAdoptionRequest: Response status: ${response.statusCode}');
    print('PetAdoptionRequest: Response body: ${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print('PetAdoptionRequest: Decoded response: $decoded');
      return List<PetAdoption>.from(decoded.map((json) => PetAdoption.fromJson(json)));
    } else {
      throw Exception('Failed to fetch pet adoption list: ${response.statusCode}');
    }
  }
}