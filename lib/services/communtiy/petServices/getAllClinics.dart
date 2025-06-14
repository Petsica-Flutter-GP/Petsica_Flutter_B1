import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/services/communtiy/petServices/clinicResponseModel.dart';

class ClinicsRequest {
  static const String baseUrl = 'http://petsica.runasp.net/me';
  static String endpoint = 'allClinics';

  static Future<List<Clinic>> getAllClinics() async {
    final url = Uri.parse('$baseUrl/$endpoint');
    print('ClinicsRequest: Fetching clinics from $url');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
      headers: {'Content-Type': 'application/json'},
    );

    print('ClinicsRequest: Response status: ${response.statusCode}');
    print('ClinicsRequest: Response headers: ${response.headers}');
    print('ClinicsRequest: Response body: ${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print('ClinicsRequest: Decoded response: $decoded');
      return List<Clinic>.from(decoded.map((json) => Clinic.fromJson(json)));
    } else {
      throw Exception('Failed to fetch clinics: ${response.statusCode} - ${response.body}');
    }
  }
}