import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petsica/core/constants.dart'; // تأكد من أن الكود يحتوي على هذا اللون

class MessageBubble extends StatefulWidget {
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
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool isLiked = false;
  bool isDisliked = false;
  bool isLikeScaled = false;
  bool isDislikeScaled = false;

  bool isWellFormed(String text) {
    try {
      text.runes.toList();
      return true;
    } catch (e) {
      return false;
    }
  }

  void animateScale(VoidCallback onComplete, Function(bool) setScale) {
    setState(() {
      setScale(true);
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        setScale(false);
      });
      onComplete();
    });
  }

  Widget _buildAnimatedIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    required bool isScaled,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isScaled ? 1.3 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Tooltip(
          message: tooltip,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Icon(
              icon,
              size: 16,
              color: color ?? Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }

  // حفظ الرسائل المعروضة بالفعل
  static Set<String> shownMessages = {};

  @override
  Widget build(BuildContext context) {
    final bool showAnimation = !widget.isUser &&
        widget.message != 'typing_indicator' &&
        isWellFormed(widget.message) &&
        !shownMessages.contains(widget.message);

    if (showAnimation) {
      shownMessages.add(widget.message); // إضافة الرسالة بعد عرضها
    }

    // التحقق من لغة الجهاز
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Padding(
      padding: widget.isUser
          ? const EdgeInsets.symmetric(horizontal: 10) // للمستخدم بدون تعديل
          : const EdgeInsets.symmetric(horizontal: 40), // للبوت مع Padding أكبر
      child: Column(
        crossAxisAlignment: widget.isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start, // محاذاة الرسائل حسب المستخدم أو البوت
        children: [
          widget.isUser
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: kBurgColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      widget.message,
                      textDirection: isArabic
                          ? TextDirection.rtl
                          : TextDirection.ltr, // تغيير الاتجاه بناءً على اللغة
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        height: 1.4,
                      ),
                    ),
                  ),
                )
              : widget.message == 'typing_indicator'
                  ? const TypingIndicatorDots()
                  : isWellFormed(widget.message)
                      ? showAnimation
                          ? AnimatedTextWriter(
                              text: widget.message,
                              color: Colors.black,
                              fontSize: 16,
                              textAlign: TextAlign.right,
                            )
                          : Text(
                              widget.message,
                              textDirection: isArabic
                                  ? TextDirection.rtl
                                  : TextDirection
                                      .ltr, // تغيير الاتجاه بناءً على اللغة
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Cairo',
                                height: 1.4,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.timestamp,
                style: TextStyle(
                  color: widget.isUser ? Colors.white70 : Colors.black54,
                  fontSize: 12,
                  fontFamily: 'Cairo',
                ),
              ),
              if (!widget.isUser) ...[
                const SizedBox(width: 8),
                _buildAnimatedIconButton(
                  icon: Icons.copy,
                  tooltip: "نسخ الرسالة",
                  isScaled: false,
                  color: Colors.grey[700],
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: widget.message));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('تم نسخ الرسالة إلى الحافظة!')),
                    );
                  },
                ),
                const SizedBox(width: 8),
                _buildAnimatedIconButton(
                  icon: isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                  tooltip: "أعجبتني",
                  isScaled: isLikeScaled,
                  color: isLiked ? Colors.blue : Colors.grey[700],
                  onTap: () {
                    animateScale(() {
                      setState(() {
                        isLiked = !isLiked;
                        if (isLiked) isDisliked = false;
                      });
                    }, (val) => setState(() => isLikeScaled = val));
                  },
                ),
                const SizedBox(width: 8),
                _buildAnimatedIconButton(
                  icon: isDisliked
                      ? Icons.thumb_down
                      : Icons.thumb_down_alt_outlined,
                  tooltip: "لم تعجبني",
                  isScaled: isDislikeScaled,
                  color: isDisliked ? Colors.red : Colors.grey[700],
                  onTap: () {
                    animateScale(() {
                      setState(() {
                        isDisliked = !isDisliked;
                        if (isDisliked) isLiked = false;
                      });
                    }, (val) => setState(() => isDislikeScaled = val));
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
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

class AnimatedTextWriter extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;

  const AnimatedTextWriter({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 16.0,
    this.textAlign = TextAlign.right,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: TextStyle(
            fontSize: fontSize,
            fontFamily: 'Cairo',
            color: color,
            height: 1.4,
          ),
          speed: const Duration(milliseconds: 25),
        ),
      ],
      isRepeatingAnimation: false,
      totalRepeatCount: 1,
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
      pause: Duration.zero,
    );
  }
}

class ChatBScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  ChatBScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 10, // عدد الرسائل هنا
        itemBuilder: (context, index) {
          return MessageBubble(
            message: "رسالة $index",
            timestamp: "12:00 PM",
            isUser: index % 2 == 0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // التمرير للأسفل عند إضافة رسالة جديدة
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
