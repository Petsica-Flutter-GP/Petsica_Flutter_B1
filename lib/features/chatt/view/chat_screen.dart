import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/chatt/logic/chat_cubit.dart';
import 'package:petsica/features/chatt/widget/chat_screen_body.dart';

class ChatScreen extends StatelessWidget {
  final String receiverId;
  final String senderId;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.senderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = ChatCubit(receiverId, senderId);
        cubit.fetchMessages(); // استدعاء الرسائل أول ما الصفحة تفتح
        return cubit;
      },
      child: const ChatScreenBody(),
    );
  }
}
