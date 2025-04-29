import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String timestamp;
  final bool isUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.timestamp,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? kBurgColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
            fontSize: 16,
            fontFamily: 'Cairo',
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
