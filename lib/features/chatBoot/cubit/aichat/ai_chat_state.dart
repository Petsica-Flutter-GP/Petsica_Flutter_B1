import 'package:petsica/features/chatBoot/widgets/chat_boot_view_body.dart';

abstract class AIChatState {}

class AIChatInitial extends AIChatState {}

class MessageSending extends AIChatState {}

class MessagesLoaded extends AIChatState {
  final List<AIChatMessage> messages;
  MessagesLoaded({required this.messages});
}

class ChatError extends AIChatState {
  final String message;
  ChatError(this.message);
}
