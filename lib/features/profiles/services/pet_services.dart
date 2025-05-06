import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/profiles/model/get_pet_model.dart';
import 'package:petsica/features/profiles/model/post_pet_model.dart';

class PetServices {
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

   static Future<List<GetPetModel>> getAllPets() async {
    final url = Uri.parse('http://petsica.runasp.net/api/Pets/GetAllPets');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      final List petsJson = decoded['value'] ?? [];

      return petsJson.map((json) => GetPetModel.fromJson(json)).toList();
    } else {
      throw Exception('فشل في جلب الحيوانات: ${response.statusCode}');
    }
  }




  static Future<GetPetModel> getPetDetails(int petId) async {
  final url = Uri.parse('http://petsica.runasp.net/api/pets/GetPetprofil/$petId');

  final response = await sendAuthorizedRequest(
    url: url,
    method: 'GET',
  );

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    final petJson = decoded['value'];
    return GetPetModel.fromJson(petJson);
  } else {
    throw Exception('❌❌Failed to get pet details: ${response.statusCode}');
  }
}


static Future<void> petAdoptionToggleOn(int petId) async {
    final url = Uri.parse('http://petsica.runasp.net/api/Pets/PetAdoptionToggle/$petId'); 
    try {
      final response = await sendAuthorizedRequest(url:url,method:  'POST'); 
      if (response.statusCode == 200) {
        log('Toggled Successfully');
      } else {
        log('Toggle Failed ${response.statusCode}');
        Exception('❌❌Failed to Toggle Adoption: ${response.statusCode}');
      }
    } catch (e) {
      log('Excption: $e');
    }
  }

}
