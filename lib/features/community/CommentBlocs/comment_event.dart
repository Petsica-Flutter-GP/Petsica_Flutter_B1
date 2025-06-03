abstract class CommentsEvent {}

class FetchComments extends CommentsEvent {
  final String postId;

  FetchComments(this.postId);
}

class AddComment extends CommentsEvent {
  final String postId;
  final String content;

  AddComment(this.postId, this.content);
}

class DeleteComment extends CommentsEvent {
  final String commentId;

  DeleteComment(this.commentId);
}