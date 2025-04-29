import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/chatBoot/cubit/aichat/ai_chat_state.dart';
import 'package:http/http.dart' as http;
import 'package:petsica/features/chatBoot/widgets/chat_boot_view_body.dart';

class AIChatCubit extends Cubit<AIChatState> {
  AIChatCubit() : super(AIChatInitial());

  Future<void> sendMessage(String message) async {
    try {
      emit(MessageSending());

      final response = await http.post(
        Uri.parse('https://5050-35-240-233-137.ngrok-free.app/ask'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: json.encode({'question': message}),
      );

      log("رسالة المستخدم: $message");
      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes);
        final data = json.decode(responseBody);
        final aiResponse = data['answer'] as String;

        final currentState = state;
        if (currentState is MessagesLoaded) {
          final updatedMessages =
              List<AIChatMessage>.from(currentState.messages)
                ..addAll([
                  AIChatMessage(
                    text: message,
                    isUser: true,
                    timestamp: DateTime.now(),
                  ),
                  AIChatMessage(
                    text: aiResponse,
                    isUser: false,
                    timestamp: DateTime.now(),
                  ),
                ]);
          emit(MessagesLoaded(messages: updatedMessages));
        } else {
          emit(MessagesLoaded(messages: [
            AIChatMessage(
              text: message,
              isUser: true,
              timestamp: DateTime.now(),
            ),
            AIChatMessage(
              text: aiResponse,
              isUser: false,
              timestamp: DateTime.now(),
            ),
          ]));
        }
      } else {
        emit(ChatError('فشل في جلب رد من الذكاء الاصطناعي'));
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
