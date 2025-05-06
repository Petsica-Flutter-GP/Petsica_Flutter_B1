import 'package:petsica/features/chatt/model/message_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class MessageLoading extends ChatState {}

class MessageSuccess extends ChatState {
  final List<MessageModel> messages;

  MessageSuccess(this.messages);
}

class MessageFailed extends ChatState {
  final String errorMessage;

  MessageFailed(this.errorMessage);
}
