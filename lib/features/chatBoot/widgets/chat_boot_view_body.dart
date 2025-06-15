import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/chatBoot/cubit/aichat/ai_chat_cubit.dart';
import 'package:petsica/features/chatBoot/cubit/aichat/ai_chat_state.dart';
import 'package:petsica/features/chatBoot/widgets/message_bubble.dart';

class ChatBootViewBody extends StatefulWidget {
  const ChatBootViewBody({super.key});

  @override
  State<ChatBootViewBody> createState() => _ChatBootViewBodyState();
}

class _ChatBootViewBodyState extends State<ChatBootViewBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(BuildContext context) {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      context.read<AIChatCubit>().sendMessage(message);
      _controller.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kChatBackGroundColor,
      appBar: AppBar(
        title: Text("Chat-Bot", style: Styles.textStyleQui24),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kChatBootOnboarding),
      ),
      body: BlocConsumer<AIChatCubit, AIChatState>(
        listener: (context, state) {
          if (state is MessagesLoaded) {
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: state is MessagesLoaded
                    ? ListView.builder(
                        controller: _scrollController,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final msg = state.messages[index];
                          return MessageBubble(
                            message: msg.text,
                            timestamp:
                                "${msg.timestamp.hour}:${msg.timestamp.minute}",
                            isUser: msg.isUser,
                          );
                        },
                      )
                    : const Center(child: Text("ٍStart chat with chat-bot✨")),
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
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffeae1e2),
                            hintText: 'Ask any thing...',
                            labelStyle: Styles.textStyleQui20,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
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
                        onPressed: () => _sendMessage(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
