// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class OtpResend {
//   static const String _baseUrl = "http://petsica.runasp.net/Auth/resend-confirmation-email";

//   static Future<Map<String, dynamic>> otpResend({
//     required String email,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse(_baseUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"Email": email}),
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
