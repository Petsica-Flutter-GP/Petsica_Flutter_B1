import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:petsica/features/chatBoot/cubit/aichat/ai_chat_state.dart';
import 'package:petsica/features/chatBoot/models/ai_message_mpdel.dart';

class AIChatCubit extends Cubit<AIChatState> {
  AIChatCubit() : super(MessagesLoaded(messages: const []));

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

    // 2. أضف رسالة "جاري الكتابة..."
    final typingMessage = AIChatMessage(
      text: 'typing_indicator', // تمييزها لاحقًا
      timestamp: DateTime.now(),
      isUser: false,
    );

    final messagesWithTyping = List<AIChatMessage>.from(updatedMessages)
      ..add(typingMessage);

    emit(MessagesLoaded(messages: messagesWithTyping));

    try {
      // 3. إرسال للـ API
      final url = Uri.parse('https://668a-34-55-39-72.ngrok-free.app/ask');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'question': message}),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final botResponseText = utf8.decode(
          responseBody['answer'].toString().codeUnits,
        );

        final botMessage = AIChatMessage(
          text: botResponseText,
          timestamp: DateTime.now(),
          isUser: false,
        );

        // 4. حذف مؤشر الكتابة، وإضافة الرد الحقيقي
        final finalMessages = List<AIChatMessage>.from(updatedMessages)
          ..add(botMessage);

        emit(MessagesLoaded(messages: finalMessages));
      } else {
        final errorMessage = AIChatMessage(
          text: "حدث خطأ أثناء الحصول على الرد",
          timestamp: DateTime.now(),
          isUser: false,
        );
        final finalMessages = List<AIChatMessage>.from(updatedMessages)
          ..add(errorMessage);

        emit(MessagesLoaded(messages: finalMessages));
      }
    } catch (e) {
      final errorMessage = AIChatMessage(
        text: "حدث استثناء أثناء الاتصال بالسيرفر",
        timestamp: DateTime.now(),
        isUser: false,
      );
      final finalMessages = List<AIChatMessage>.from(updatedMessages)
        ..add(errorMessage);

      emit(MessagesLoaded(messages: finalMessages));
    }
  }
}

}
