import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/features/community/widgets/post_input_field.dart';
import 'package:petsica/services/signup/add_post_service.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _postController = TextEditingController();
  bool _isPosting = false;

  void _submitPost() async {
    setState(() => _isPosting = true);

    final content = _postController.text.trim();
    if (content.isEmpty) return;

    final success = await PostService.addPost(content);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(success ? '✅ Post submitted!' : '❌ Failed to post'),
      ));
    }

    if (success) _postController.clear();

    setState(() => _isPosting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            PostInputField(controller: _postController),
            const SizedBox(height: 20),
            Center(
              child: AppButton(
                text: _isPosting ? "Posting..." : "Post",
                border: 20,
                onTap: _isPosting ? null : _submitPost,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
