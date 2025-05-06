class MessageModel {
  final int messageID;
  final String clinicReceiverID;
  final String clinicSenderID;
  final String content;
  final String date;

  MessageModel({
    required this.messageID,
    required this.clinicReceiverID,
    required this.clinicSenderID,
    required this.content,
    required this.date,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageID: json['messageID'],
      clinicReceiverID: json['clinicReceiverID'],
      clinicSenderID: json['clinicSenderID'],
      content: json['content'],
      date:(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinicReceiverID': clinicReceiverID,
      'clinicSenderID': clinicSenderID,
      'content': content,
      'date': date,
    };
  }
}
