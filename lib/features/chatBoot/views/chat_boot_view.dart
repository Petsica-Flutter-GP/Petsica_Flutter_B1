import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/chatBoot/cubit/aichat/ai_chat_cubit.dart';
import 'package:petsica/features/chatBoot/widgets/chat_boot_view_body.dart';

class ChatBootView extends StatelessWidget {
  const ChatBootView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AIChatCubit>(
      create: (_) => AIChatCubit(), // إنشاء الـ Cubit
      child: const ChatBootViewBody(), // تمرير الـ ChatBootViewBody
    );
  }
}
