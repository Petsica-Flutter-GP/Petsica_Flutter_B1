import 'dart:convert';
import 'dart:developer';
import 'package:petsica/core/utils/send_Authorized_Request.dart';

class UserProfileModel {
  final String email;
  final String userName;
  final String? photo;
  final String? address;

  UserProfileModel({
    required this.email,
    required this.userName,
    this.photo,
    this.address,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      email: json['email'],
      userName: json['userName'],
      photo: json['photo'],
      address: json['address'],
    );
  }
}

class UserService {
  static Future<UserProfileModel> getUserProfile() async {
    final url = Uri.parse('http://petsica.runasp.net/me');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      log('📦 Decoded response: $decoded');

      return UserProfileModel.fromJson(decoded); // ✅ هنا التعديل
    } else {
      throw Exception('❌ Failed to get data: ${response.statusCode}');
    }
  }




  static Future<void> updateUserProfile({
    required String userName,
    required String photo,
    required String address,
    required String location,
  }) async {
    final url = Uri.parse('http://petsica.runasp.net/me/info');

    final body = jsonEncode({
      "userName": userName,
      "photo": 'photo',
      "address": address,
      "location": location,
    });

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'PUT',
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      log("✅ Profile updated successfully");
    } else {
      throw Exception("❌ Failed to update profile: ${response.statusCode}");
    }
  }




}
