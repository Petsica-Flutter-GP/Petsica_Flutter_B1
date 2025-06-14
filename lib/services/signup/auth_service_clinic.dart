import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AuthServiceClinic {
  static const String _baseUrl = "http://petsica.runasp.net/Auth/registerUser";

  static Future<Map<String, dynamic>> registerClinic({
    required String userName,
    required String email,
    required String password,
    required String address,
    required String workingHours,
    required String phone,
    required File verificationImage, // ✅ الصورة
    File? profileImage, // ✅ اختياري
  }) async {
    try {
      final uri = Uri.parse(_baseUrl);
      var request = http.MultipartRequest('POST', uri);

      request.fields.addAll({
        "userName": userName,
        "email": email,
        "password": password,
        "address": address,
        "type": "CLINIC",
        "workingHours": workingHours,
        "contactInfo": phone,
        "nationalID": "string",
      });

      // ✅ صورة التوثيق (مطلوبة)
      request.files.add(
        await http.MultipartFile.fromPath(
            "approvalPhoto", verificationImage.path),
      );

      // ✅ صورة البروفايل (لو متوفرة)
      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath("photo", profileImage.path),
        );
      } else {
        request.fields["photo"] = "string"; // أو تسيبيها فاضية حسب API
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 204) {
        return {"success": true, "message": "Registration successful"};
      } else {
        final Map<String, dynamic> responseData =
            response.body.isNotEmpty ? jsonDecode(response.body) : {};
        return {
          "success": false,
          "message": responseData["message"] ??
              responseData["error"] ??
              "Registration failed"
        };
      }
    } catch (e) {
      return {"success": false, "message": "Network error: $e"};
    }
  }
}
