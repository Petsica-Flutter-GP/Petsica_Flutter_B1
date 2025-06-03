import 'dart:convert';
import 'package:flutter/material.dart';

class Post {
  final String postId;
  final String content;
  final String userId;
  final String? username;
  final String? photoBase64;
  final int likesCount;
  final int commentCount;

  const Post({
    required this.postId,
    required this.content,
    required this.userId,
    this.username,
    this.photoBase64,
    required this.likesCount,
    required this.commentCount,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    print('Post.fromJson: Raw JSON: $json');
    final rawPostId = json['postId'] ?? json['PostId'] ?? json['id'] ?? '';
    print('Post.fromJson: Raw postId: $rawPostId');
    final rawContent = json['Content'] ?? json['content'] ?? '';
    print('Post.fromJson: Raw content: $rawContent');
    final rawUserId = json['UserId'] ?? json['userId'] ?? json['user_id'] ?? '';
    print('Post.fromJson: Raw userId: $rawUserId');
    final rawLikesCount = json['LikesCount'] ?? json['likesCount'] ?? 0;
    print('Post.fromJson: Raw likesCount: $rawLikesCount');
    final rawCommentCount = json['CommentCount'] ?? json['commentCount'] ?? 0;
    print('Post.fromJson: Raw commentCount: $rawCommentCount');
    final rawUsername =
        json['username'] ?? json['Username'] ?? json['userName'];
    print('Post.fromJson: Raw username: $rawUsername');
    final rawPhoto = json['photo'] ?? json['Photo'];
    print('Post.fromJson: Raw photo: $rawPhoto');

    return Post(
      postId: rawPostId.toString(),
      content: rawContent.toString(),
      userId: rawUserId.toString(),
      username: rawUsername?.toString(),
      photoBase64: rawPhoto?.toString(),
      likesCount: int.tryParse(rawLikesCount.toString()) ?? 0,
      commentCount: int.tryParse(rawCommentCount.toString()) ?? 0,
    );
  }

  Image? get photoImage {
    if (photoBase64 == null || photoBase64!.isEmpty) return null;
    try {
      final bytes = base64Decode(photoBase64!);
      return Image.memory(
        bytes,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } catch (e) {
      print('Post.photoImage: Error decoding photo: $e');
      return null;
    }
  }

  @override
  String toString() {
    return 'Post(postId: $postId, content: $content, userId: $userId, username: $username, likesCount: $likesCount, commentCount: $commentCount)';
  }
}
