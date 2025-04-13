import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';

class ChatBootViewBody extends StatefulWidget {
  const ChatBootViewBody({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatBootViewBody> {
  final TextEditingController _controller = TextEditingController();
  final List<String> messages = ["Hello!", "How are you?"];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text);
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kChatBackGroundColor,
      appBar: AppBar(
        title: Text("Chat-Boot", style: Styles.textStyleQui24),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kChatBootOnboarding),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: messages[index],
                  timestamp: '7:20',
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: const Color(0xffeae1e2),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        filled: true, // ✅ يجعل الخلفية مملوءة باللون
                        fillColor: const Color(
                            0xffeae1e2), // ✅ تحديد لون الخلفية (يمكنك تغييره)
                        hintText:
                            'Ask anything...', // يمكن تعديل النص هنا إذا أردت
                        labelStyle: Styles.textStyleQui20,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.transparent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      size: 40,
                      color: kBurgColor,
                    ),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String timestamp; // لإضافة الوقت

  const MessageBubble(
      {super.key, required this.message, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // لتوسيط النصوص في الجهة اليسرى
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: kBurgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Text(
                message,
                style: Styles.textStyleQui20.copyWith(color: kWhiteGroundColor),
              ),
            ),
            Text(
              timestamp, // الوقت الذي سيتم عرضه هنا
              style: Styles.textStyleQui16
                  .copyWith(color: kWordColor.withOpacity(0.6), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}


/*

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';

class ChatBootViewBody extends StatefulWidget {
  const ChatBootViewBody({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatBootViewBody> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> messages = [
    Message(text: "Hello!", sender: "other"),
    Message(text: "How are you?", sender: "other")
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(Message(text: _controller.text, sender: "me"));
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kChatBackGroundColor,
      appBar: AppBar(
        title: Text("Chat-Boot", style: Styles.textStyleQui24),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kChatBootOnboarding),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: messages[index].text,
                  timestamp: '7:20',
                  sender: messages[index].sender,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: const Color(0xffeae1e2),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        filled: true, // ✅ يجعل الخلفية مملوءة باللون
                        fillColor: const Color(
                            0xffeae1e2), // ✅ تحديد لون الخلفية (يمكنك تغييره)
                        hintText:
                            'Ask anything...', // يمكن تعديل النص هنا إذا أردت
                        labelStyle: Styles.textStyleQui20,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.transparent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      size: 40,
                      color: kBurgColor,
                    ),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final String sender; // "me" أو "other"

  Message({required this.text, required this.sender});
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String timestamp;
  final String sender; // لإضافة مرسل الرسالة

  const MessageBubble(
      {super.key,
      required this.message,
      required this.timestamp,
      required this.sender});

  @override
  Widget build(BuildContext context) {
    bool isUserMessage =
        sender == "me"; // التحقق مما إذا كانت الرسالة من المستخدم

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Align(
        alignment: isUserMessage
            ? Alignment.centerRight
            : Alignment.centerLeft, // تغيير الاتجاه بناءً على المرسل
        child: Column(
          crossAxisAlignment: isUserMessage
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start, // توجيه النص إلى اليمين أو اليسار
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUserMessage
                    ? kBurgColor
                    : kWhiteGroundColor, // تحديد لون الفقاعة بناءً على المرسل
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomRight: isUserMessage
                      ? const Radius.circular(18)
                      : Radius.zero, // الزاوية السفلية اليمنى فقط للمستخدم
                  bottomLeft: isUserMessage
                      ? Radius.zero
                      : const Radius.circular(
                          18), // الزاوية السفلية اليسرى فقط للشخص الآخر
                ),
              ),
              child: Text(
                message,
                style: Styles.textStyleQui20.copyWith(color: kWhiteGroundColor),
              ),
            ),
            Text(
              timestamp, // الوقت الذي سيتم عرضه هنا
              style: Styles.textStyleQui16
                  .copyWith(color: kWordColor.withOpacity(0.6), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}


*/