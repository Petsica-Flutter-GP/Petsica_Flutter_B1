import 'package:flutter/material.dart';

class BotTypingIndicator extends StatefulWidget {
  const BotTypingIndicator({super.key});

  @override
  State<BotTypingIndicator> createState() => _BotTypingIndicatorState();
}

class _BotTypingIndicatorState extends State<BotTypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dotOne;
  late Animation<double> _dotTwo;
  late Animation<double> _dotThree;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _dotOne = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4)),
    );
    _dotTwo = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.6)),
    );
    _dotThree = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(_dotOne),
        const SizedBox(width: 4),
        _buildDot(_dotTwo),
        const SizedBox(width: 4),
        _buildDot(_dotThree),
      ],
    );
  }

  Widget _buildDot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.only(bottom: animation.value),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
