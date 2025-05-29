import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/community/CommentBlocs/comment_event.dart';
import 'package:petsica/features/community/CommentBlocs/comment_state.dart';
import 'package:petsica/services/communtiy/comment/add_comment_service.dart';
import 'package:petsica/services/communtiy/comment/comment_response_model.dart';
import 'package:petsica/services/communtiy/comment/delete_comment_service.dart';
import 'package:petsica/services/communtiy/comment/get_comments_service.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(const CommentsState()) {
    on<FetchComments>(_onFetchComments);
    on<AddComment>(_onAddComment);
    on<DeleteComment>(_onDeleteComment);
  }

  Future<void> _onFetchComments(FetchComments event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, deleteSuccess: false, commentAdded: false, commentDeleted: false));
    try {
      final List<Comment> comments = await GetCommentsService.getComments(event.postId);
      print('CommentsBloc: Fetched ${comments.length} comments for postId: ${event.postId}');
      emit(state.copyWith(
        isLoading: false,
        comments: comments,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
        deleteSuccess: false,
        commentAdded: false,
        commentDeleted: false,
      ));
      print('CommentsBloc: Error fetching comments: $e');
    }
  }

  Future<void> _onAddComment(AddComment event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, deleteSuccess: false, commentAdded: false, commentDeleted: false));
    try {
      final (success, errorMessage) = await AddCommentService.addComment(event.postId, event.content);
      print('CommentsBloc: AddCommentService.addComment(${event.postId}) returned: success=$success, errorMessage=$errorMessage');
      if (success) {
        final List<Comment> comments = await GetCommentsService.getComments(event.postId);
        emit(state.copyWith(
          isLoading: false,
          comments: comments,
          error: null,
          commentAdded: true,
        ));
        print('CommentsBloc: Successfully added comment and updated list for postId: ${event.postId}');
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: errorMessage ?? 'Failed to add comment',
          deleteSuccess: false,
          commentAdded: false,
          commentDeleted: false,
        ));
        print('CommentsBloc: Failed to add comment for postId: ${event.postId}, error: $errorMessage');
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Error adding comment: $e',
        deleteSuccess: false,
        commentAdded: false,
        commentDeleted: false,
      ));
      print('CommentsBloc: Error adding comment: $e');
    }
  }

  Future<void> _onDeleteComment(DeleteComment event, Emitter<CommentsState> emit) async {
    print('CommentsBloc: Handling DeleteComment event for commentId: ${event.commentId}');
    emit(state.copyWith(isLoading: true, error: null, deleteSuccess: false, commentAdded: false, commentDeleted: false));
    try {
      final (success, errorMessage) = await DeleteCommentService.deleteComment(event.commentId);
      print('CommentsBloc: DeleteCommentService.deleteComment(${event.commentId}) returned: success=$success, errorMessage=$errorMessage');
      if (success) {
        final updatedComments = List<Comment>.from(state.comments)
          ..removeWhere((comment) => comment.commentId == event.commentId);

        emit(state.copyWith(
          isLoading: false,
          comments: updatedComments,
          error: null,
          deleteSuccess: true,
          commentDeleted: true,
        ));
        print('CommentsBloc: Successfully deleted commentId: ${event.commentId}');
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: errorMessage ?? 'Failed to delete comment',
          deleteSuccess: false,
          commentAdded: false,
          commentDeleted: false,
        ));
        print('CommentsBloc: Failed to delete commentId: ${event.commentId}, error: $errorMessage');
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Error deleting comment: $e',
        deleteSuccess: false,
        commentAdded: false,
        commentDeleted: false,
      ));
      print('CommentsBloc: Error deleting commentId: ${event.commentId}, $e');
    }
  }
}