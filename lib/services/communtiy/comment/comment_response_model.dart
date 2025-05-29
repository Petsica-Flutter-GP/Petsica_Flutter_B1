class Comment {
  final String commentId;
  final String userId;
  final String content;
  final String date;

  Comment({
    required this.commentId,
    required this.userId,
    required this.content,
    required this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    print('Comment.fromJson: Raw JSON: $json');
    final rawCommentId = json['CommentId'] ?? json['commentId'] ?? json['comment_id'] ?? json['id'] ?? json['CommentID'];
    print('Comment.fromJson: Raw commentId: $rawCommentId');
    final rawContent = json['Content'] ?? json['content'] ?? json['Text'] ?? json['text'];
    print('Comment.fromJson: Raw content: $rawContent');
    final rawUserId = json['UserID'] ?? json['userId'] ?? json['user_id'] ?? json['UserId'];
    print('Comment.fromJson: Raw userId: $rawUserId');
    final rawDate = json['Date'] ?? json['date'] ?? json['CreatedAt'] ?? json['createdAt'];
    print('Comment.fromJson: Raw date: $rawDate');

    return Comment(
      commentId: rawCommentId?.toString() ?? '',
      userId: rawUserId?.toString() ?? '',
      content: rawContent?.toString() ?? '',
      date: rawDate?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'Comment(commentId: $commentId, userId: $userId, content: $content, date: $date)';
  }
}