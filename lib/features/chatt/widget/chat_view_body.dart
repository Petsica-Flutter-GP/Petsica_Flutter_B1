
// // 📁 chat_screen.dart
// import 'package:flutter/material.dart';
// import 'package:petsica/features/chatt/model/message_model.dart';
// import 'package:petsica/features/chatt/services/chat_services.dart';
// import 'package:petsica/features/chatt/services/chat_web_socket_services.dart';

// class ChatViewBody extends StatefulWidget {
//   final String senderId;
//   final String receiverId;

//   const ChatViewBody({required this.senderId, required this.receiverId, super.key});

//   @override
//   State<ChatViewBody> createState() => _ChatViewBodyState();
// }

// class _ChatViewBodyState extends State<ChatViewBody> {
//   final TextEditingController _controller = TextEditingController();
//   late ChatWebSocketService _webSocketService;
//   List<ChatMessageModel> messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _webSocketService = ChatWebSocketService(userId: widget.senderId);
//     fetchMessages();
//     _webSocketService.getMessageStream().listen((msg) {
//       if ((msg.clinicSenderID == widget.receiverId && msg.clinicReceiverID == widget.senderId) ||
//           (msg.clinicSenderID == widget.senderId && msg.clinicReceiverID == widget.receiverId)) {
//         setState(() => messages.add(msg));
//       }
//     });
//   }

//   Future<void> fetchMessages() async {
//     try {
//       final msgs = await ChatService.getMessages(widget.receiverId, widget.senderId);
//       setState(() => messages = msgs);
//     } catch (e) {
//       print("Error fetching messages: $e");
//     }
//   }

//   void sendMessage() {
//     if (_controller.text.isEmpty) return;
//     final message = ChatMessageModel(
//       clinicSenderID: widget.senderId,
//       clinicReceiverID: widget.receiverId,
//       content: _controller.text.trim(),
//       date: DateTime.now().toIso8601String(),
//     );
//     _controller.clear();
//     _webSocketService.sendMessage(message);
//   }

//   @override
//   void dispose() {
//     _webSocketService.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("الرسائل")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               reverse: true,
//               itemCount: messages.length,
//               itemBuilder: (_, index) {
//                 final msg = messages[messages.length - index - 1];
//                 final isMine = msg.clinicSenderID == widget.senderId;
//                 return Align(
//                   alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isMine ? Colors.green[100] : Colors.grey[200],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(msg.content),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(child: TextField(controller: _controller)),
//               IconButton(icon: const Icon(Icons.send), onPressed: sendMessage),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
