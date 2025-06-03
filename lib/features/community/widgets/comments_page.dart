import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/features/community/CommentBlocs/comment_bloc.dart';
import 'package:petsica/features/community/CommentBlocs/comment_event.dart';
import 'package:petsica/features/community/CommentBlocs/comment_state.dart';
import 'package:petsica/features/community/widgets/comment_card.dart';

class CommentsPage extends StatefulWidget {
  final String postId;

  const CommentsPage({super.key, required this.postId});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _commentController = TextEditingController();
  bool _hasFetchedComments = false;

  @override
  void initState() {
    super.initState();
    if (!_hasFetchedComments) {
      context.read<CommentsBloc>().add(FetchComments(widget.postId));
      _hasFetchedComments = true;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final state = context.read<CommentsBloc>().state;
        Navigator.pop(context, (added: state.commentAdded, deleted: state.commentDeleted));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comments', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<CommentsBloc, CommentsState>(
                listener: (context, state) {
                  if (state.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${state.error}', style: const TextStyle(color: Colors.white)),
                        duration: const Duration(seconds: 5),
                        backgroundColor: Colors.red[700],
                        action: SnackBarAction(
                          label: 'Retry',
                          textColor: Colors.white,
                          onPressed: () {
                            context.read<CommentsBloc>().add(FetchComments(widget.postId));
                          },
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF2C3E50)));
                  }
                  if (state.comments.isEmpty) {
                    return const Center(child: Text('No comments yet.', style: TextStyle(color: Color(0xFF7F8C8D))));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<CommentsBloc>().add(FetchComments(widget.postId));
                    },
                    color: Color(0xFF2C3E50),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        final comment = state.comments[index];
                        return CommentCard(comment: comment);
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, -2))],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle: const TextStyle(color: Color(0xFF7F8C8D)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: kBurgColor),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      maxLines: 3,
                      minLines: 1, // Start with one line
                      style: const TextStyle(fontSize: 14, color: Color(0xFF2C3E50)),
                    ),
                  ),
                  // const SizedBox(width: 8),
                  // IconButton(
                  //   icon: const Icon(Icons.emoji_emotions, color: kBurgColor),
                  //   onPressed: () {
                  //     // Placeholder for emoji picker integration
                  //   },
                  // ),
                  IconButton(
                    icon: const Icon(Icons.send, color: kBurgColor),
                    onPressed: () {
                      final content = _commentController.text.trim();
                      if (content.isNotEmpty) {
                        context.read<CommentsBloc>().add(AddComment(widget.postId, content));
                        _commentController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}