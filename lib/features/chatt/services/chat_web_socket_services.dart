// // 📁 chat_websocket_service.dart
// import 'dart:convert';

// import 'package:petsica/features/chatt/model/message_model.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';


// class ChatWebSocketService {
//   final String userId;
//   final _channel = WebSocketChannel.connect(
//     Uri.parse("ws://petsica.runasp.net/chatHub"),
//   );

//   ChatWebSocketService({required this.userId});

//   void sendMessage(ChatMessageModel message) {
//     final jsonMessage = json.encode(message.toJson());
//     _channel.sink.add(jsonMessage);
//   }

//   Stream<ChatMessageModel> getMessageStream() {
//     return _channel.stream.map((data) {
//       final decoded = json.decode(data);
//       return ChatMessageModel.fromJson(decoded);
//     });
//   }

//   void dispose() {
//     _channel.sink.close();
//   }
// }