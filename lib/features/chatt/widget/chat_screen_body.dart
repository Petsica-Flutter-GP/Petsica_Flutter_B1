import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/chatt/logic/chat_cubit.dart';
import 'package:petsica/features/chatt/logic/chat_state.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is MessageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MessageFailed) {
          return Center(child: Text(state.errorMessage));
        } else if (state is MessageSuccess) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return ListTile(
                      title: Text(message.content),
                      subtitle: Text(message.date),
                    );
                  },
                ),
              ),
              _buildMessageInput(context),
            ],
          );
        }
        return const Center(child: Text("حدث خطأ غير متوقع"));
      },
    );
  }
}

Widget _buildMessageInput(BuildContext context) {
  final TextEditingController textController = TextEditingController();

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: textController,
            onSubmitted: (value) {
              context.read<ChatCubit>().sendMessage(value);
              textController.clear();
            },
            decoration: const InputDecoration(
              hintText: 'أرسل رسالة...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            context.read<ChatCubit>().sendMessage(textController.text);
            textController.clear();
          },
        ),
      ],
    ),
  );
}
