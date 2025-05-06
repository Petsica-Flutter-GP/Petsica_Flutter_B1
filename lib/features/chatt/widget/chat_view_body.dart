// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:petsica/features/chatt/logic/chat_cubit.dart';
// import 'package:petsica/features/chatt/logic/chat_state.dart';

// class CChatScreenBody extends StatefulWidget {
//   final String receiverId;
//   final String senderId;

//   const CChatScreenBody({
//     super.key,
//     required this.receiverId,
//     required this.senderId,
//   });

//   @override
//   State<CChatScreenBody> createState() => _CChatScreenBodyState();
// }

// class _CChatScreenBodyState extends State<CChatScreenBody> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<ChatCubit>().loadMessages(
//           receiverId: widget.receiverId,
//           senderId: widget.senderId,
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: BlocBuilder<ChatCubit, ChatState>(
//             builder: (context, state) {
//               if (state is ChatLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is ChatLoaded) {
//                 return ListView.builder(
//                   reverse: true,
//                   itemCount: state.messages.length,
//                   itemBuilder: (context, index) {
//                     final message =
//                         state.messages[state.messages.length - 1 - index];
//                     final isMe = message.clinicSenderID == widget.senderId;
//                     return Align(
//                       alignment:
//                           isMe ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 4, horizontal: 8),
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: isMe ? Colors.green[100] : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(message.content),
//                       ),
//                     );
//                   },
//                 );
//               } else if (state is ChatError) {
//                 return Center(child: Text("خطأ: ${state.message}"));
//               } else {
//                 return Container();
//               }
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _controller,
//                   decoration: const InputDecoration(hintText: 'اكتب رسالة...'),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.send),
//                 onPressed: () {
//                   final text = _controller.text.trim();
//                   if (text.isNotEmpty) {
//                     context.read<ChatCubit>().sendMessage(
//                           receiverId: widget.receiverId,
//                           senderId: widget.senderId,
//                           content: text,
//                         );
//                     _controller.clear();
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
