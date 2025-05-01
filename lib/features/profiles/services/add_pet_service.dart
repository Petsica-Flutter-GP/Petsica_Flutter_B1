import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';

class PetService {
  static Future<void> addPet({
    required String name,
    required String type,
    required String age,
    required String gender,
    required String photoBase64,
  }) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Pets/AddPet');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'POST',
      body: jsonEncode({
        "name": name,
        "breed": type,
        "species": age,
        "gender": gender,
        "photo": photoBase64,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return;
    } else {
      throw Exception('❌ فشل في إضافة الحيوان الأليف: ${response.statusCode}');
    }
  }
}
