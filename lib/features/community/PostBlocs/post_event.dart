abstract class PostEvent {}

class FetchPosts extends PostEvent {}

class DeletePost extends PostEvent {
  final String postId;

  DeletePost(this.postId);
}