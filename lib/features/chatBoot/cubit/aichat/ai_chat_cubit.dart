import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:petsica/features/chatBoot/cubit/aichat/ai_chat_state.dart';
import 'package:petsica/features/chatBoot/models/ai_message_mpdel.dart';

class AIChatCubit extends Cubit<AIChatState> {
  AIChatCubit() : super(MessagesLoaded(messages: const []));

  bool _isTyping = false; // ✅ لتفادي تكرار مؤشر الكتابة

  void sendMessage(String message) async {
    final currentState = state;

    if (currentState is MessagesLoaded) {
      // 1. أضف رسالة المستخدم
      final userMessage = AIChatMessage(
        text: message,
        timestamp: DateTime.now(),
        isUser: true,
      );

      final updatedMessages = List<AIChatMessage>.from(currentState.messages)
        ..add(userMessage);

      emit(MessagesLoaded(messages: updatedMessages));

      if (_isTyping) return; // ✅ لو البوت بيرد فعليًا، ما تضيفش مؤشر جديد
      _isTyping = true;

      // 2. أضف رسالة "جاري الكتابة..." (مؤشر)
      final typingMessage = AIChatMessage(
        text: 'typing_indicator',
        timestamp: DateTime.now(),
        isUser: false,
      );

      final messagesWithTyping = List<AIChatMessage>.from(updatedMessages)
        ..add(typingMessage);

      emit(MessagesLoaded(messages: messagesWithTyping));

      try {
        // 3. إرسال الطلب إلى API
        final url = Uri.parse('https://7424-35-245-181-166.ngrok-free.app/ask');
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'question': message}),
        );

        final botMessage = response.statusCode == 200
            ? AIChatMessage(
                text: utf8.decode(
                    json.decode(response.body)['answer'].toString().codeUnits),
                timestamp: DateTime.now(),
                isUser: false,
              )
            : AIChatMessage(
                text: "حدث خطأ أثناء الحصول على الرد",
                timestamp: DateTime.now(),
                isUser: false,
              );

        // 4. احذف مؤشر الكتابة، ثم أضف رد البوت
        final finalMessages = List<AIChatMessage>.from(updatedMessages)
          ..add(botMessage);

        emit(MessagesLoaded(messages: finalMessages));
      } catch (e) {
        final errorMessage = AIChatMessage(
          text: "حدث استثناء أثناء الاتصال بالسيرفر",
          timestamp: DateTime.now(),
          isUser: false,
        );

        final finalMessages = List<AIChatMessage>.from(updatedMessages)
          ..add(errorMessage);

        emit(MessagesLoaded(messages: finalMessages));
      } finally {
        _isTyping = false; // ✅ إعادة الحالة
      }
    }
  }
}
