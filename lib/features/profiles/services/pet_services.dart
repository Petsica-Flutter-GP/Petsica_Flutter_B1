import 'dart:convert';
import 'dart:developer';
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/profiles/model/get_pet_model.dart';

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

    if (response.statusCode != 200 && response.statusCode != 204) {
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
      throw Exception('❌ فشل في جلب الحيوانات: ${response.statusCode}');
    }
  }

  static Future<GetPetModel> getPetDetails(int petId) async {
    final url =
        Uri.parse('http://petsica.runasp.net/api/pets/GetPetprofil/$petId');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final petJson = decoded['value'];
      return GetPetModel.fromJson(petJson);
    } else {
      throw Exception('❌❌ فشل في جلب تفاصيل الحيوان: ${response.statusCode}');
    }
  }

  static Future<void> toggleAdoptionStatus(int petId) async {
    final url = Uri.parse(
        'http://petsica.runasp.net/api/Pets/PetAdoptionToggle/$petId');
    try {
      final response = await sendAuthorizedRequest(url: url, method: 'POST');
      if (response.statusCode == 204) {
        log('✅ تبني: تم التبديل بنجاح');
      } else {
        log('❌ تبني: فشل التبديل ${response.statusCode}');
      }
    } catch (e) {
      log('❌ Exception أثناء تبديل التبني: $e');
    }
  }

  static Future<void> toggleMatingStatus(int petId) async {
    final url =
        Uri.parse('http://petsica.runasp.net/api/Pets/PetMatingToggle/$petId');
    try {
      final response = await sendAuthorizedRequest(url: url, method: 'POST');
      if (response.statusCode == 204) {
        log('✅ تزاوج: تم التبديل بنجاح');
      } else {
        log('❌ تزاوج: فشل التبديل ${response.statusCode}');
      }
    } catch (e) {
      log('❌ Exception أثناء تبديل التزاوج: $e');
    }
  }
}