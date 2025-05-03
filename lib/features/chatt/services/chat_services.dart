// // 📁 chat_service.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:petsica/features/chatt/model/message_model.dart';

// class ChatService {
//   static const String baseUrl = "http://petsica.runasp.net/api/Chats";

//   static Future<List<ChatMessageModel>> getMessages(String receiverId, String senderId) async {
//     final url = Uri.parse("$baseUrl/get-messages/$receiverId/$senderId");
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final List jsonList = json.decode(response.body);
//       return jsonList.map((json) => ChatMessageModel.fromJson(json)).toList();
//     } else {
//       throw Exception("Failed to fetch messages");
//     }
//   }

//   static Future<bool> sendMessage(ChatMessageModel message) async {
//     final url = Uri.parse("$baseUrl/send-message");
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: json.encode(message.toJson()),
//     );

//     return response.statusCode == 200;
//   }
// }