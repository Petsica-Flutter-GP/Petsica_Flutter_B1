// // 📁 chat_message_model.dart
// class ChatMessageModel {
//   final int? messageID;
//   final String clinicReceiverID;
//   final String clinicSenderID;
//   final String content;
//   final String date;

//   ChatMessageModel({
//     this.messageID,
//     required this.clinicReceiverID,
//     required this.clinicSenderID,
//     required this.content,
//     required this.date,
//   });

//   factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
//     return ChatMessageModel(
//       messageID: json['messageID'],
//       clinicReceiverID: json['clinicReceiverID'],
//       clinicSenderID: json['clinicSenderID'],
//       content: json['content'],
//       date: json['date'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "ClinicReceiverID": clinicReceiverID,
//       "ClinicSenderID": clinicSenderID,
//       "Content": content,
//       "Date": date,
//     };
//   }
// }