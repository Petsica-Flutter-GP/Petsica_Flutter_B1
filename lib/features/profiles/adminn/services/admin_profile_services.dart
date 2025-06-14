import 'dart:convert';
import 'dart:developer';

import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/profiles/adminn/services/model/clinic_details_request.dart';
import 'package:petsica/features/profiles/adminn/services/model/sitter_approval_model.dart';
import 'package:petsica/features/profiles/sitter/models/sitter_services_model.dart';

class AdminProfileServices {
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
          "❌ Failed to fetch seller approvals: ${response.statusCode}");
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
          "❌ Failed to fetch clinic approvals: ${response.statusCode}");
    }
  }

  // ✅ Approve sitter
  static Future<void> approve(String userId) async {
    final url = Uri.parse('http://petsica.runasp.net/me/ApprovalUser');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'POST',
      body: jsonEncode({
        "userid": userId,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      log("✅ Sitter approved successfully");
    } else {
      log("❌ Failed to approve sitter: ${response.statusCode}");
      throw Exception("Failed to approve sitter");
    }
  }

  static Future<ClinicDetailsRequest> getClinicRequestDetails(
      String userId) async {
    final url = Uri.parse(
        'http://petsica.runasp.net/me/ClinicRequsestsDetails?userid=$userId');

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ClinicDetailsRequest.fromJson(json);
    } else {
      throw Exception(
          "❌ Failed to fetch clinic request details: ${response.statusCode}");
    }
  }
}
