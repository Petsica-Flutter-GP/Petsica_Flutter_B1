import 'package:equatable/equatable.dart';
import 'package:petsica/services/communtiy/post/get_all_posts_model.dart';

class PostState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<Post> posts;
  final bool deleteSuccess;

  const PostState({
    this.isLoading = false,
    this.error,
    this.posts = const [],
    this.deleteSuccess = false,
  });

  PostState copyWith({
    bool? isLoading,
    String? error,
    List<Post>? posts,
    bool? deleteSuccess,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      posts: posts ?? this.posts,
      deleteSuccess: deleteSuccess ?? this.deleteSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        posts,
        deleteSuccess,
      ];
}