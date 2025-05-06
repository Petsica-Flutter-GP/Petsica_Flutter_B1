// // // 📁 chat_websocket_service.dart
// // import 'dart:convert';

// // import 'package:petsica/features/chatt/model/message_model.dart';
// // import 'package:web_socket_channel/web_socket_channel.dart';


// // class ChatWebSocketService {
// //   final String userId;
// //   final _channel = WebSocketChannel.connect(
// //     Uri.parse("ws://petsica.runasp.net/chatHub"),
// //   );

// //   ChatWebSocketService({required this.userId});

// //   void sendMessage(ChatMessageModel message) {
// //     final jsonMessage = json.encode(message.toJson());
// //     _channel.sink.add(jsonMessage);
// //   }

// //   Stream<ChatMessageModel> getMessageStream() {
// //     return _channel.stream.map((data) {
// //       final decoded = json.decode(data);
// //       return ChatMessageModel.fromJson(decoded);
// //     });
// //   }

// //   void dispose() {
// //     _channel.sink.close();
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:zoom_way/data/api/const.dart';
// import 'package:zoom_way/data/api/passengers_api_service.dart';

// class ApiService {
//   static const String baseUrl = ApiConst.baseUrl;

//   static Future<Map<String, dynamic>?> registerPassenger(
//       {required String name,
//       required String email,
//       required String password,
//       required String passwordConfirmation,
//       required String phoneNumber,
//       required String address,
//       required String userType // Added user_type parameter
//       }) async {
//     final url = Uri.parse('$baseUrl/register');

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /'
//       },
//       body: jsonEncode({
//         'name': name,
//         'email': email,
//         'password': password,
//         'password_confirmation': passwordConfirmation,
//         'phone_number': phoneNumber,
//         'address': address,
//         'user_type': userType // Added to request body
//       }),
//     );

//     if (response.statusCode == 201) {
//       return jsonDecode(response.body);
//     } else {
//       if (kDebugMode) {
//         print('Registration Error: ${response.body}');
//       }
//       return null;
//     }
//   }

//   static String? _authToken;

//   // Method to set the auth token
//   static Future<void> setAuthToken(String token) async {
//     try {
//       _authToken = token;
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('auth_token', token);
//       await prefs.setString('user_type', 'passenger');
//     } catch (e) {
//       debugPrint('Error storing token: $e');
//     }
//   }

//   // Method to get the auth token
//   static String? getAuthToken() {
//     return _authToken;
//   }

//   // In passengers_api_service.dart - Update the login method
//   static Future<Map<String, dynamic>?> login({
//     required String email,
//     required String password,
//     required String userType,
//   }) async {
//     try {
//       final url = Uri.parse('$baseUrl/login');

//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json, text/plain, /'
//         },
//         body: jsonEncode(
//             {'email': email, 'password': password, 'user_type': userType}),
//       );

//       debugPrint('''
//     ======== LOGIN RESPONSE ========
//     Status: ${response.statusCode}
//     Body: ${response.body}
//     ================================
//     ''');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         if (data['token'] == null) {
//           debugPrint('Token missing in login response');
//           return null;
//         }

//         // Store token and user ID
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('auth_token', data['token']);
//         if (data['user'] != null && data['user']['id'] != null) {
//           await prefs.setInt('user_id', data['user']['id']);
//         }
//         await setAuthToken(data['token']);
//         return data;
//       } else {
//         debugPrint('Login failed: ${response.body}');
//         return null;
//       }
//     } catch (e) {
//       debugPrint('Login error: $e');
//       return null;
//     }
//   }

//   // Add to passengers_api_service.dart
//   static Future<void> debugCheckTokenStorage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final storedToken = prefs.getString('auth_token');

//     debugPrint('''
//   ===== TOKEN STORAGE CHECK =====
//   Static _authToken: $_authToken
//   SharedPreferences Token: $storedToken
//   ==============================
//   ''');
//   }

//   // Add to passengers_api_service.dart
//   static Future<bool> validateToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('auth_token');

//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/user'),
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       return response.statusCode == 200;
//     } catch (e) {
//       return false;
//     }
//   }

//   static Future<Map<String, dynamic>?> verifyOtp({
//     required String otp,
//     required String name,
//     required String email,
//     required String phoneNumber,
//     required String address,
//     required String password,
//     required String passwordConfirmation,
//     required String userType,
//   }) async {
//     final url = Uri.parse('$baseUrl/otp/verify');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /'
//       },
//       body: jsonEncode({
//         'otp': otp,
//         'name': name,
//         'email': email,
//         'phone_number': phoneNumber,
//         'address': address,
//         'password': password,
//         'password_confirmation': passwordConfirmation,
//         'user_type': userType,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       if (kDebugMode) {
//         print('OTP Verification Error: ${response.body}');
//       }
//       return null;
//     }
//   }

//   static Future<void> _ensureAuth() async {
//     if (_authToken == null) {
//       final prefs = await SharedPreferences.getInstance();
//       _authToken = prefs.getString('auth_token');
//     }
//   }

//   static Future<Map<String, dynamic>?> createRide({
//     required String region,
//     required Map<String, dynamic> pickupLocation,
//     required Map<String, dynamic> dropoffLocation,
//     required int passengerId,
//     required double distance,
//   }) async {
//     try {
//       await _ensureAuth(); // Ensure we have the latest token

//       if (_authToken == null) {
//         debugPrint('No auth token available for ride creation');
//         return null;
//       }

//       var headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /',
//         'Authorization': 'Bearer $_authToken' // Add authorization header
//       };

//       debugPrint('Creating ride with headers: $headers');

//       var request = http.Request('POST', Uri.parse('$baseUrl/ride'));
//       request.body = json.encode({
//         "region": region,
//         "pickup_location": pickupLocation,
//         "dropoff_location": dropoffLocation,
//         "passenger_id": passengerId,
//         "distance": distance
//       });
//       request.headers.addAll(headers);

//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();

//       debugPrint('Ride creation response status: ${response.statusCode}');
//       debugPrint('Ride creation response body: $responseBody');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return json.decode(responseBody);
//       } else {
//         debugPrint('Failed to create ride: ${response.reasonPhrase}');
//         return null;
//       }
//     } catch (e, stackTrace) {
//       debugPrint('Error creating ride: $e\n$stackTrace');
//       return null;
//     }
//   }

//   static Future<bool> testCreateRideDirectly() async {
//     try {
//       var headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /'
//       };

//       // Add authorization if available
//       if (_authToken != null) {
//         headers['Authorization'] = 'Bearer $_authToken';
//       }

//       var request = http.Request('POST', Uri.parse('$baseUrl/ride'));
//       request.body = json.encode({
//         "region": "cairo",
//         "pickup_location": {"longitude": 342546, "latitude": 342546},
//         "dropoff_location": {"longitude": 342246, "latitude": 342646},
//         "passenger_id": 1,
//         "distance": 120.5
//       });
//       request.headers.addAll(headers);

//       if (kDebugMode) {
//         print('TEST REQUEST:');
//         print('Headers: ${request.headers}');
//         print('Body: ${request.body}');
//       }

//       http.StreamedResponse response = await request.send();

//       String responseBody = await response.stream.bytesToString();
//       if (kDebugMode) {
//         print('Test response status: ${response.statusCode}');
//         print('Test response body: $responseBody');
//       }

//       return response.statusCode == 200 || response.statusCode == 201;
//     } catch (e) {
//       if (kDebugMode) {
//         print('Test exception: $e');
//       }
//       return false;
//     }
//   }

//   Future<Map<String, dynamic>> getRides() async {
//     try {
//       var headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /'
//       };

//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('auth_token');
//       if (token != null) {
//         headers['Authorization'] = 'Bearer $token';
//       }

//       var request = http.Request('GET', Uri.parse('$baseUrl/ride/'));
//       request.headers.addAll(headers);

//       http.StreamedResponse response = await request.send();
//       var responseBody = await response.stream.bytesToString();
//       var parsedResponse = json.decode(responseBody);

//       if (response.statusCode == 200) {
//         return {
//           'success': true,
//           'data': parsedResponse,
//         };
//       } else {
//         return {
//           'success': false,
//           'message': parsedResponse['message'] ?? 'Failed to fetch rides',
//         };
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'An error occurred: ${e.toString()}',
//       };
//     }
//   }

//   static Future<Map<String, dynamic>> logout() async {
//     try {
//       var headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /'
//       };

//       final token = await SharedPreferences.getInstance();
//       final authToken = token.getString('auth_token');
//       if (authToken != null) {
//         headers['Authorization'] = 'Bearer $authToken';
//       }

//       var request = http.Request('POST', Uri.parse('$baseUrl/logout'));
//       request.headers.addAll(headers);

//       http.StreamedResponse response = await request.send();
//       var responseBody = await response.stream.bytesToString();
//       var parsedResponse = json.decode(responseBody);

//       if (response.statusCode == 200) {
//         // Clear stored token
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.remove('auth_token');
//         await prefs.remove('user_type');

//         return {
//           'success': true,
//           'message': parsedResponse['message'] ?? 'Logged out successfully',
//         };
//       } else {
//         return {
//           'success': false,
//           'message': parsedResponse['message'] ?? 'Failed to logout',
//         };
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'An error occurred: ${e.toString()}',
//       };
//     }
//   }

//   Future<Map<String, dynamic>> getUserProfile() async {
//     try {
//       debugPrint('Fetching user profile...');
//       var headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /'
//       };

//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('auth_token');
//       if (token != null) {
//         headers['Authorization'] = 'Bearer $token';
//         debugPrint('Auth token found and added to headers');
//       } else {
//         debugPrint('No auth token found');
//       }

//       debugPrint('Making API request to: $baseUrl/user');
//       var request = http.Request('GET', Uri.parse('$baseUrl/user'));
//       request.headers.addAll(headers);
//       debugPrint('Request headers: ${request.headers}');

//       http.StreamedResponse response = await request.send();
//       var responseBody = await response.stream.bytesToString();
//       debugPrint('Response status code: ${response.statusCode}');
//       debugPrint('Response body: $responseBody');

//       if (response.statusCode == 200) {
//         var parsedResponse = json.decode(responseBody);
//         debugPrint('Successfully parsed user profile data');
//         return {
//           'success': true,
//           'data': parsedResponse,
//         };
//       } else {
//         debugPrint('Failed to fetch profile. Status: ${response.statusCode}');
//         return {
//           'success': false,
//           'message': 'Failed to fetch user profile',
//         };
//       }
//     } catch (e) {
//       debugPrint('Error fetching user profile: $e');
//       return {
//         'success': false,
//         'message': 'An error occurred: ${e.toString()}',
//       };
//     }
//   }

//   Future<Map<String, dynamic>> deleteAccount(String password) async {
//     try {
//       debugPrint('Attempting to delete account...');
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('auth_token');
//       if (token == null) {
//         debugPrint('No auth token found');
//         return {
//           'success': false,
//           'message': 'Not authenticated. Please login again.',
//         };
//       }

//       final response = await http.delete(
//         Uri.parse('$baseUrl/user'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode({
//           'password': password,
//         }),
//       );

//       debugPrint('Delete account response: ${response.body}');

//       if (response.statusCode == 200) {
//         await prefs.clear();
//         return {
//           'success': true,
//           'message': 'Account deleted successfully',
//         };
//       } else {
//         var responseData = json.decode(response.body);
//         return {
//           'success': false,
//           'message': responseData['message'] ?? 'Failed to delete account',
//         };
//       }
//     } catch (e) {
//       debugPrint('Error deleting account: $e');
//       return {
//         'success': false,
//         'message': 'An error occurred while deleting account',
//       };
//     }
//   }

//   Future<Map<String, dynamic>> updateUserProfile(
//       Map<String, dynamic> data) async {
//     try {
//       debugPrint('Updating user profile: $data');
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('auth_token');

//       final response = await http.put(
//         Uri.parse('$baseUrl/user'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode(data),
//       );

//       debugPrint('Update profile response: ${response.body}');

//       if (response.statusCode == 200) {
//         return {
//           'success': true,
//           'data': json.decode(response.body),
//         };
//       } else {
//         return {
//           'success': false,
//           'message': 'Failed to update profile',
//         };
//       }
//     } catch (e) {
//       debugPrint('Error updating profile: $e');
//       return {
//         'success': false,
//         'message': 'An error occurred while updating profile',
//       };
//     }
//   }

//   Future<Map<String, dynamic>> changePassword({
//     required String currentPassword,
//     required String newPassword,
//     required String confirmPassword,
//   }) async {
//     try {
//       debugPrint('Attempting to change password...');
//       var headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /'
//       };

//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('auth_token');
//       if (token != null) {
//         headers['Authorization'] = 'Bearer $token';
//       }

//       var request = http.Request('PUT', Uri.parse('$baseUrl/change-password'));
//       request.headers.addAll(headers);
//       request.body = json.encode({
//         'current_password': currentPassword,
//         'password': newPassword,
//         'password_confirmation': confirmPassword,
//       });

//       http.StreamedResponse response = await request.send();
//       var responseBody = await response.stream.bytesToString();
//       debugPrint('Change password response: $responseBody');

//       if (response.statusCode == 200) {
//         return {
//           'success': true,
//           'message': 'Password changed successfully',
//         };
//       } else {
//         return {
//           'success': false,
//           'message':
//               'Failed to change password. Please check your current password.',
//         };
//       }
//     } catch (e) {
//       debugPrint('Error changing password: $e');
//       return {
//         'success': false,
//         'message': 'An error occurred while changing password',
//       };
//     }
//   }

// // Add this method to ApiService class
//   static Future<Map<String, dynamic>> sendMessage({
//     required int rideId,
//     required String message,
//     required String senderType,
//     required String receiverType,
//     required int senderId,
//     required int receiverId,
//   }) async {
//     try {
//       await _ensureAuth(); // Make sure we have the auth token

//       var headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /',
//         'Authorization': 'Bearer $_authToken'
//       };

//       if (_authToken != null) {
//         headers['Authorization'] = 'Bearer $_authToken';
//         debugPrint('[API] Using token: $_authToken');
//       }

//       var request = http.Request('POST', Uri.parse('$baseUrl/messages'));
//       request.headers.addAll(headers);
//       request.body = json.encode({
//         "ride_id": rideId,
//         "message": message,
//         "sender_type": senderType,
//         "receiver_type": receiverType,
//         "sender_id": senderId,
//         "receiver_id": receiverId
//       });

//       http.StreamedResponse response = await request.send();
//       var responseBody = await response.stream.bytesToString();

//       if (response.statusCode == 200) {
//         debugPrint('Message sent successfully: $responseBody');
//         return {
//           'success': true,
//           'data': json.decode(responseBody),
//         };
//       } else {
//         debugPrint('Failed to send message: $responseBody');
//         return {
//           'success': false,
//           'message': 'Failed to send message',
//         };
//       }
//     } catch (e) {
//       debugPrint('Error sending message: $e');
//       return {
//         'success': false,
//         'message': 'An error occurred: ${e.toString()}',
//       };
//     }
//   }

//   // Add method to get chat messages for a ride
//   static Future<Map<String, dynamic>> getChatMessages(int rideId) async {
//     try {
//       await _ensureAuth();

//       var headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /',
//         'Authorization': 'Bearer $_authToken'
//       };

//       if (_authToken != null) {
//         headers['Authorization'] = 'Bearer $_authToken';
//         debugPrint('[API] Using token: $_authToken');
//       }

//       var request = http.Request('GET', Uri.parse('$baseUrl/messages/$rideId'));
//       request.headers.addAll(headers);

//       http.StreamedResponse response = await request.send();
//       var responseBody = await response.stream.bytesToString();

//       if (response.statusCode == 200) {
//         return {
//           'success': true,
//           'data': json.decode(responseBody),
//         };
//       } else {
//         return {
//           'success': false,
//           'message': 'Failed to fetch messages',
//         };
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'An error occurred: ${e.toString()}',
//       };
//     }
//   }

//   static Future<Map<String, dynamic>?> getActiveRide(int rideId) async {
//     try {
//       await _ensureAuth();
//       if (_authToken == null) {
//         debugPrint('No auth token available for getting ride');
//         return null;
//       }

//       final response = await http.get(
//         Uri.parse('$baseUrl/ride/$rideId'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $_authToken'
//         },
//       );

//       debugPrint('Get ride response status: ${response.statusCode}');
//       debugPrint('Get ride response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         return responseData;
//       } else {
//         debugPrint('Failed to get ride: ${response.reasonPhrase}');
//         return null;
//       }
//     } catch (e) {
//       debugPrint('Error getting ride: $e');
//       return null;
//     }
//   }

//   static Future<String?> getToken() async {
//     if (_authToken != null) {
//       return _authToken;
//     }

//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('auth_token');
//     if (token != null) {
//       _authToken = token;
//     }
//     return token;
//   }

//   // Get all notifications
//   Future<Map<String, dynamic>> getNotifications() async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         return {'success': false, 'message': 'No authentication token found'};
//       }

//       final response = await http.get(
//         Uri.parse('$baseUrl/notifications'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> notifications = json.decode(response.body);

//         // debugPrint('Notifications response status: ${response.statusCode}');
//         // debugPrint('Notifications response body: ${response.body}');
//         return {
//           'success': true,
//           'data': notifications,
//         };
//       } else {
//         return {
//           'success': false,
//           'message': 'Failed to fetch notifications: ${response.reasonPhrase}',
//         };
//       }
//     } catch (e) {
//       debugPrint('Error fetching notifications: $e');
//       return {
//         'success': false,
//         'message': 'Error fetching notifications: $e',
//       };
//     }
//   }

//   // Get single notification
//   Future<Map<String, dynamic>> getNotification(String notificationId) async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         return {
//           'success': false,
//           'message': 'Authentication token not found',
//         };
//       }

//       final headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /',
//         'Authorization': 'Bearer $token',
//       };

//       final response = await http.get(
//         Uri.parse('$baseUrl/notifications/$notificationId'),
//         headers: headers,
//       );

//       if (response.statusCode == 200) {
//         return {
//           'success': true,
//           'data': json.decode(response.body),
//         };
//       } else {
//         return {
//           'success': false,
//           'message': 'Failed to fetch notification: ${response.reasonPhrase}',
//         };
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Error fetching notification: $e',
//       };
//     }
//   }

//   // Delete notification
//   Future<Map<String, dynamic>> deleteNotification(String notificationId) async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         return {
//           'success': false,
//           'message': 'Authentication token not found',
//         };
//       }

//       final headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /',
//         'Authorization': 'Bearer $token',
//       };

//       final response = await http.delete(
//         Uri.parse('$baseUrl/notifications/$notificationId'),
//         headers: headers,
//       );

//       if (response.statusCode == 200) {
//         return {
//           'success': true,
//           'message': 'Notification deleted successfully',
//         };
//       } else {
//         return {
//           'success': false,
//           'message': 'Failed to delete notification: ${response.reasonPhrase}',
//         };
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Error deleting notification: $e',
//       };
//     }
//   }

//   static Future<List<Map<String, dynamic>>> getRideBids(int rideId) async {
//     try {
//       await _ensureAuth();

//       var headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /',
//         'Authorization': 'Bearer $_authToken'
//       };

//       final url = Uri.parse('$baseUrl/rides/$rideId/bids');
//       final response = await http.get(url, headers: headers);

//       if (response.statusCode == 200) {
//         // Cast the response data correctly
//         final List<dynamic> jsonData = json.decode(response.body);

//         return List<Map<String, dynamic>>.from(
//           jsonData.map((item) => Map<String, dynamic>.from(item)),
//         );
//       }
//       // debugPrint('Bids response status: ${response.statusCode}');
//       // debugPrint('Bids response body: ${response.body}');
//       return [];
//     } catch (e) {
//       debugPrint('Error getting bids: $e');
//       return <Map<String, dynamic>>[];
//     }
//   }

//   static Future<Map<String, dynamic>> chooseBid(int rideId, int bidId) async {
//     try {
//       await _ensureAuth();

//       var headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json, text/plain, /'
//       };

//       if (_authToken != null) {
//         headers['Authorization'] = 'Bearer $_authToken';
//       }

//       var request =
//           http.Request('POST', Uri.parse('$baseUrl/rides/$rideId/choose-bid'));

//       request.headers.addAll(headers);
//       request.body = json.encode({"bid_id": bidId});

//       http.StreamedResponse response = await request.send();
//       var responseBody = await response.stream.bytesToString();

//       if (response.statusCode == 200) {
//         return {
//           'success': true,
//           'data': json.decode(responseBody),
//         };
//       } else {
//         return {
//           'success': false,
//           'message': 'Failed to choose bid',
//         };
//       }
//     } catch (e) {
//       debugPrint('Error choosing bid: $e');
//       return {
//         'success': false,
//         'message': 'An error occurred: ${e.toString()}',
//       };
//     }
//   }

//   static Future<List<Map<String, dynamic>>> getAllRides() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('auth_token');
//       final response = await http.get(
//         Uri.parse('$baseUrl/ride'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json, text/plain, /',
//           'Authorization': 'Bearer $token'
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         return List<Map<String, dynamic>>.from(data);
//       }
//       return [];
//     } catch (e) {
//       print('Error getting all rides: $e');
//       return [];
//     }
//   }

  
// }