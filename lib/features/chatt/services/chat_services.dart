import 'dart:convert';

import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/chatt/model/message_model.dart';

class ChatService {
  static Future<List<MessageModel>> getMessages({
    required String receiverId,
    required String senderId,
  }) async {
    final url = Uri.parse("http://petsica.runasp.net/api/Chats/get-messages/$receiverId/$senderId");

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => MessageModel.fromJson(e)).toList();
    } else {
      throw Exception("فشل تحميل الرسائل");
    }
  }

  static Future<void> sendMessage({
    required MessageModel message,
  }) async {
    final url = Uri.parse("http://petsica.runasp.net/api/Chats/send-message");

    final body = json.encode(message.toJson());

    final response = await sendAuthorizedRequest(
      url: url,
      method: 'POST',
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception("فشل إرسال الرسالة");
    }
  }
}
