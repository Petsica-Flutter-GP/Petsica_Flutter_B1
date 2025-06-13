import 'dart:convert';
import 'dart:developer';

import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/profiles/adminn/services/model/sitter_approval_model.dart';
import 'package:petsica/features/profiles/sitter/models/sitter_services_model.dart';

class AdminProfileServices {
// // ✅ Get sitter services
//   static Future<List<SitterServiceModel>> getSitterServices() async {
//     final url = Uri.parse('http://petsica.runasp.net/me/GetAllSitterService');

//     final response = await sendAuthorizedRequest(
//       url: url,
//       method: 'GET',
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = jsonDecode(response.body);

//       return jsonList.map((json) => SitterServiceModel.fromJson(json)).toList();
//     } else {
//       throw Exception("❌ Failed to fetch services: ${response.statusCode}");
//     }
//   }

// ✅ Get sitter approvals
  static Future<List<SitterApprovalModel>> getSitterApprovals() async {
    final url = Uri.parse('http://petsica.runasp.net/me/GetSitterApproval');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList
          .map((json) => SitterApprovalModel.fromJson(json))
          .toList();
    } else {
      throw Exception(
          "❌ Failed to fetch sitter approvals: ${response.statusCode}");
    }
  }

// ✅ Get seller approvals
  static Future<List<SitterApprovalModel>> getSellerApprovals() async {
    final url = Uri.parse('http://petsica.runasp.net/me/GetSellerApproval');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList
          .map((json) => SitterApprovalModel.fromJson(json))
          .toList();
    } else {
      throw Exception(
          "❌ Failed to fetch sitter approvals: ${response.statusCode}");
    }
  }

// ✅ Get clinic approvals
  static Future<List<SitterApprovalModel>> getClinicApprovals() async {
    final url = Uri.parse('http://petsica.runasp.net/me/GetClinicApproval');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList
          .map((json) => SitterApprovalModel.fromJson(json))
          .toList();
    } else {
      throw Exception(
          "❌ Failed to fetch sitter approvals: ${response.statusCode}");
    }
  }

// ✅ Approve sitter
  static Future<void> approve(String userId) async {
    final url = Uri.parse('http://petsica.runasp.net/me/ApprovalUser');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'POST',
      body: {
        "userid": userId,
      },
    );

    if (response.statusCode == 200) {
      log("✅ Sitter approved successfully");
    } else {
      log("❌ Failed to approve sitter: ${response.statusCode}");
      throw Exception("Failed to approve sitter");
    }
  }
}
