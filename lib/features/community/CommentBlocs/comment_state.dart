import 'package:equatable/equatable.dart';
import 'package:petsica/services/communtiy/comment/comment_response_model.dart';

class CommentsState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<Comment> comments;
  final bool deleteSuccess;
  final bool commentAdded;
  final bool commentDeleted;

  const CommentsState({
    this.isLoading = false,
    this.error,
    this.comments = const [],
    this.deleteSuccess = false,
    this.commentAdded = false,
    this.commentDeleted = false,
  });

  CommentsState copyWith({
    bool? isLoading,
    String? error,
    List<Comment>? comments,
    bool? deleteSuccess,
    bool? commentAdded,
    bool? commentDeleted,
  }) {
    return CommentsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      comments: comments ?? this.comments,
      deleteSuccess: deleteSuccess ?? this.deleteSuccess,
      commentAdded: commentAdded ?? this.commentAdded,
      commentDeleted: commentDeleted ?? this.commentDeleted,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        comments,
        deleteSuccess,
        commentAdded,
        commentDeleted,
      ];
}