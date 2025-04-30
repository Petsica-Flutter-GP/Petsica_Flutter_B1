import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:typewritertext/typewritertext.dart';

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

  bool isWellFormed(String text) {
    try {
      // محاولة تحويل النص إلى قائمة "رونز" (Unicode code points)
      text.runes.toList();
      return true;
    } catch (e) {
      // في حال حدوث استثناء يعني أن النص غير صالح
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? kBurgColor : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(16),
          ),
          border: Border.all(
            color: isUser ? Colors.transparent : Colors.grey,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            isUser
                ? Text(
                    message,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Cairo',
                      height: 1.4,
                    ),
                    maxLines: null, // Allow multi-line
                    overflow:
                        TextOverflow.visible, // Ensure no clipping of text
                  )
                : message == 'typing_indicator'
                    ? const TypingIndicatorDots()
                    : isWellFormed(message)
                        ? TypeWriterText(
                            text: Text(
                              _getWords(message),
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Cairo',
                                height: 1.4,
                              ),
                            ),
                            duration: const Duration(
                                milliseconds: 1), // Adjust speed here
                          )       

                        : const Text(
                            "⚠ لا يمكن عرض هذه الرسالة",
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
            const SizedBox(height: 5),
            Text(
              timestamp,
              style: TextStyle(
                color: isUser ? Colors.white70 : Colors.black54,
                fontSize: 12,
                fontFamily: 'Cairo',
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Function to split message into words and display them one by one
String _getWords(String message) {
  List<String> words =
      message.split(" "); // Split message by spaces to get words
  String result = '';
  for (var word in words) {
    result += "$word "; // Add one word at a time to the result
  }
  return result;
}

class TypingIndicatorDots extends StatefulWidget {
  const TypingIndicatorDots({super.key});

  @override
  State<TypingIndicatorDots> createState() => _TypingIndicatorDotsState();
}

class _TypingIndicatorDotsState extends State<TypingIndicatorDots>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (i) => AnimationController(
        duration: const Duration(milliseconds: 50),
        vsync: this,
      )..repeat(reverse: true, period: Duration(milliseconds: 900 + (i * 100))),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          return AnimatedBuilder(
            animation: _animations[i],
            builder: (_, __) => Opacity(
              opacity: _animations[i].value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
