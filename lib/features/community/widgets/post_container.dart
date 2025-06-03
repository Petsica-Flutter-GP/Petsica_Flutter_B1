import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/features/community/CommentBlocs/comment_bloc.dart';
import 'package:petsica/features/community/PostBlocs/post_bloc.dart';
import 'package:petsica/features/community/PostBlocs/post_event.dart';
import 'package:petsica/features/community/widgets/comments_page.dart';
import 'package:petsica/services/communtiy/like/add&delete_like.dart';
import 'package:petsica/services/communtiy/post/get_all_posts_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  Future<void> _deletePost(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirm == true) {
      context.read<PostBloc>().add(DeletePost(post.postId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _deletePost(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: kContainerColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ► HEADER: avatar, author name
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(AssetData.profileIcon),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Pero Osama",
                    style: Styles.textStyleQui20.copyWith(color: kBurgColor),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ► CONTENT TEXT
            Text(
              post.content.isNotEmpty ? post.content : 'No caption',
              style: const TextStyle(fontSize: 16),
            ),

            // ► OPTIONAL PHOTO
            if (post.photoImage != null) ...[
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: post.photoImage!,
              ),
            ],

            const SizedBox(height: 16),

            // ► LIKE & COMMENT ROW
            Row(
              children: [
                LikeButton(postId: post.postId, initialCount: post.likesCount),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () async {
                    await Navigator.push<({bool added, bool deleted})>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => CommentsBloc(),
                          child: CommentsPage(postId: post.postId),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.comment_outlined, color: Colors.grey),
                      // const SizedBox(width: 4),
                      // Text('${post.commentCount}', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  final String postId;
  final int initialCount;

  const LikeButton({
    Key? key,
    required this.postId,
    required this.initialCount,
  }) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late int _count;
  bool _isLiked = false;
  bool _isToggling = false;
  late String _userId;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
    _loadState();
  }

  Future<void> _loadState() async {
    _userId = (await TokenStorage.getUserId()) ?? '';
    if (_userId.isEmpty) return;
    final saved = await TokenStorage.getLikeState(_userId, widget.postId);
    if (mounted && saved != null) {
      setState(() => _isLiked = saved);
    }
  }

  Future<void> _toggle() async {
    if (_isToggling || _userId.isEmpty) return;
    setState(() => _isToggling = true);

    final prevLiked = _isLiked;
    // optimistic:
    setState(() {
      _isLiked = !prevLiked;
      _count += prevLiked ? -1 : 1;
    });

    final (success, err) = prevLiked
      ? await LikeDislikeService.dislikePost(widget.postId)
      : await LikeDislikeService.likePost(widget.postId);

    if (!success) {
      // rollback
      setState(() {
        _isLiked = prevLiked;
        _count += prevLiked ? 1 : -1;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err ?? 'Error toggling like'), backgroundColor: kBurgColor),
        );
      }
    } else {
      await TokenStorage.saveLikeState(_userId, widget.postId, _isLiked);
    }

    setState(() => _isToggling = false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border,
            color: _isToggling
              ? Colors.grey[400]
              : (_isLiked ? kBurgColor : Colors.grey),
          ),
          onPressed: _toggle,
          tooltip: _isLiked ? 'Unlike' : 'Like',
        ),
        const SizedBox(width: 4),
        Text('$_count', style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}