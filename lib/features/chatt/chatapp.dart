// import 'package:flutter/material.dart';
// import 'package:petsica/features/chatt/signalr_services.dart';

// class SignalRChatApp extends StatelessWidget {
//   const SignalRChatApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'SignalR Chat',
//       home: ChatPage(),
//     );
//   }
// }

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final SignalRService _signalRService = SignalRService();
//   final TextEditingController _userController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//   final List<String> _messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _initializeSignalR();
//   }

//   void _initializeSignalR() async {
//     await _signalRService
//         .initConnection("http://petsica.runasp.net/clinicChatHub");
//     _signalRService.onReceiveMessage((args) {
//       setState(() {
//         _messages.add("${args?[0]}: ${args?[1]}");
//       });
//     });
//   }

//   void _sendMessage() {
//     final user = _userController.text.trim();
//     final message = _messageController.text.trim();
//     if (user.isNotEmpty && message.isNotEmpty) {
//       _signalRService.sendMessage(user, message);
//       _messageController.clear();
//     }
//   }

//   @override
//   void dispose() {
//     _signalRService.stopConnection();
//     _userController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('SignalR Chat'),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _userController,
//                 decoration: const InputDecoration(labelText: 'Username'),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _messages.length,
//                 itemBuilder: (context, index) => ListTile(
//                   title: Text(_messages[index]),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(labelText: 'Message'),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.send),
//                     onPressed: _sendMessage,
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:petsica/features/chatt/signalr_services.dart';

class SignalRChatApp extends StatelessWidget {
  const SignalRChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SignalR Chat',
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final SignalRService _signalRService = SignalRService();
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  bool isClinic = true;

  @override
  void initState() {
    super.initState();
    _initializeSignalR();
  }

 @override
void _initializeSignalR() async {
  try {
    await _signalRService.initConnection("http://petsica.runasp.net/clinicChatHub");
    _signalRService.onReceiveMessage((args) {
      setState(() {
        _messages.add("${args?[0]}: ${args?[1]}");
      });
    });
  } catch (e) {
    log("Failed to connect: $e");
  }
}


  void _sendMessage() async {
  final user = isClinic ? "clinic_1" : "user_1";  // ربما يجب استخدام ID فعلي بدلاً من الاسم
  final message = _messageController.text.trim();

  if (message.isNotEmpty) {
    try {
      await _signalRService.sendMessage(user, message);
      _messageController.clear();
      log("Message sent: $message");
    } catch (e) {
      log("Failed to send message: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send message: $e")),
      );
    }
  }
}

  @override
  void dispose() {
    _signalRService.stopConnection();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userLabel = isClinic ? "Clinic" : "User";

    return Scaffold(
      appBar: AppBar(
        title: Text('SignalR Chat - $userLabel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            tooltip: 'Switch User',
            onPressed: () {
              setState(() {
                isClinic = !isClinic;
              });
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_messages[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(labelText: 'Message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
