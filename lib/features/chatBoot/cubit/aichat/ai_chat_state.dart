import 'package:equatable/equatable.dart';
import 'package:petsica/features/chatBoot/models/ai_message_mpdel.dart';

abstract class AIChatState extends Equatable {}

class AIChatInitial extends AIChatState {
  @override
  List<Object?> get props => [];
}

class MessageSending extends AIChatState {
  @override
  List<Object?> get props => [];
}

class MessagesLoaded extends AIChatState {
  final List<AIChatMessage> messages;

  MessagesLoaded({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class ChatError extends AIChatState {
  final String message;

  ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
