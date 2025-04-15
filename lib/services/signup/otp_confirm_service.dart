// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class OtpConfirmService {
//   static const String _baseUrl = "http://petsica.runasp.net/Auth/confirm-email";

//   static Future<Map<String, dynamic>> otpConfirm({
//     required String email,
//     required String otp,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse(_baseUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"Email": email, "code": otp}),
//       );

//       if (response.statusCode == 204) {
//         return {"success": true, "message": "Confirmed successful"};
//       } else {
//         final Map<String, dynamic> responseData = response.body.isNotEmpty
//             ? jsonDecode(response.body)
//             : {}; // Handle empty response

//         return {
//           "success": false,
//           "message": responseData["message"] ??
//               responseData["error"] ??
//               "Confirmation failed"
//         };
//       }
//     } catch (e) {
//       return {"success": false, "message": "Network error: $e"};
//     }
//   }
// }
