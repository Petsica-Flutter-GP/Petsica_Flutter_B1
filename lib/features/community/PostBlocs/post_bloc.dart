import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/services/communtiy/post/delete_post.dart';
import 'package:petsica/services/communtiy/post/get_all_posts_model.dart';
import 'package:petsica/services/communtiy/post/get_all_posts_service.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<FetchPosts>(_onFetchPosts);
    on<DeletePost>(_onDeletePost);
    add(FetchPosts());
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, deleteSuccess: false));
    try {
      final jsonPosts = await GetPostsService.getAllPosts();
      print('PostBloc: Fetched ${jsonPosts.length} posts');
      final newPosts = jsonPosts.map((json) => Post.fromJson(json)).toList();
      for (var post in newPosts) {
        print('PostBloc: PostId: ${post.postId}, LikesCount: ${post.likesCount}, CommentCount: ${post.commentCount}');
      }
      emit(state.copyWith(
        isLoading: false,
        posts: newPosts,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
        deleteSuccess: false,
      ));
      print('PostBloc: Error fetching posts: $e');
    }
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    print('PostBloc: Handling DeletePost event for postId: ${event.postId}');
    emit(state.copyWith(isLoading: true, error: null, deleteSuccess: false));
    try {
      final (success, errorMessage) = await DeletePostService.deletePost(event.postId);
      print('PostBloc: DeletePostService.deletePost(${event.postId}) returned: success=$success, errorMessage=$errorMessage');
      if (success) {
        final updatedPosts = List<Post>.from(state.posts)
          ..removeWhere((post) => post.postId == event.postId);

        emit(state.copyWith(
          isLoading: false,
          posts: updatedPosts,
          error: null,
          deleteSuccess: true,
        ));
        print('PostBloc: Successfully deleted postId: ${event.postId}');
        add(FetchPosts());
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: errorMessage ?? 'Failed to delete post',
          deleteSuccess: false,
        ));
        print('PostBloc: Failed to delete postId: ${event.postId}, error: $errorMessage');
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Error deleting post: $e',
        deleteSuccess: false,
      ));
      print('PostBloc: Error deleting postId: ${event.postId}, $e');
    }
  }
}