// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:petsica/features/chatt/logic/chat_cubit.dart';

// class CChatScreen extends StatelessWidget {
//   final String receiverId;
//   final String senderId;

//   const ChatScreen({Key? key, required this.receiverId, required this.senderId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('الدردشة')),
//       body: BlocProvider(
//         create: (_) => ChatCubit(receiverId, senderId),
//         child: ChatScreenBody(),
//       ),
//     );
//   }
// }
