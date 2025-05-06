import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/chatt/logic/chat_state.dart';
import 'package:petsica/features/chatt/model/message_model.dart';

class ChatCubit extends Cubit<ChatState> {
  final String receiverId;
  final String senderId;

  ChatCubit(this.receiverId, this.senderId) : super(MessageLoading());

  void sendMessage(String content) async {
    try {
      final response = await http.post(
        Uri.parse('http://petsica.runasp.net/api/Chats/send-message'),
        body: json.encode({
          'ClinicReceiverID': receiverId,
          'ClinicSenderID': senderId,
          'Content': content,
          'Date': DateTime,
        }),
      );

      if (response.statusCode == 200) {
        fetchMessages(); 
      } else {
        emit(MessageFailed('فشل في إرسال الرسالة'));
      }
    } catch (e) {
      emit(MessageFailed(e.toString()));
    }
  }

  void fetchMessages() async {
    try {
      emit(MessageLoading()); // بداية تحميل الرسائل

      final response = await http.get(
        Uri.parse(
            'http://petsica.runasp.net/api/Chats/get-messages/$receiverId/$senderId'),
      );

      log('Response status: ${response.statusCode}'); // لعرض حالة الاستجابة
      log('Response body: ${response.body}'); // لعرض محتوى الاستجابة

      if (response.statusCode == 200) {
        final messagesJson = json.decode(response.body);
        log('Messages data: $messagesJson'); // تحقق من بيانات الرسائل

        final messages = List<MessageModel>.from(
            messagesJson.map((message) => MessageModel.fromJson(message)));
        emit(MessageSuccess(messages)); // إظهار الرسائل المحملة
      } else {
        emit(MessageFailed('فشل في تحميل الرسائل'));
      }
    } catch (e) {
      log('Error: $e'); // عرض الخطأ في حال حدوثه
      emit(MessageFailed(e.toString()));
    }
  }
}
