import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/features/community/CommentBlocs/comment_bloc.dart';
import 'package:petsica/features/community/CommentBlocs/comment_event.dart';
import 'package:petsica/services/communtiy/comment/comment_response_model.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({
    super.key,
    required this.comment,
  });

  Future<void> _deleteComment(BuildContext context) async {
    if (comment.commentId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Comment ID is empty')),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Comment'),
        content: const Text('Are you sure you want to delete this comment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      context.read<CommentsBloc>().add(DeleteComment(comment.commentId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _deleteComment(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: const AssetImage(AssetData.profileIcon),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pero Osama", // Replace with dynamic username if needed
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: kBurgColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment.content.isNotEmpty ? comment.content : "No content",
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFF34495E),
                    ),
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