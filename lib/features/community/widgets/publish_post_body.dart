import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/features/community/widgets/post_input_field.dart';
import 'package:petsica/services/communtiy/post/add_post_service.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _postController = TextEditingController();
  File? _selectedImage;
  bool _isPosting = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
        print('PostPage: Selected image path: ${picked.path}'); // Debug log
      });
    }
  }

  Future<void> _submitPost() async {
    final content = _postController.text.trim();
    if (content.isEmpty || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter text and select an image.")),
      );
      return;
    }

    setState(() => _isPosting = true);

    try {
      // Encode image as Base64 string
      final bytes = await _selectedImage!.readAsBytes();
      final base64Image = base64Encode(bytes);
      print('PostPage: Image Base64 length: ${base64Image.length}'); // Debug log

      final success = await PostService.addPost(
        content: content,
        imageBase64: base64Image,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(success ? '✅ Post submitted!' : '❌ Failed to post')),
        );
      }

      if (success) {
        _postController.clear();
        setState(() => _selectedImage = null);
        print('PostPage: Popping with success = true'); // Debug log
        Navigator.pop(context, true); // Ensure pop with true
      }
    } catch (e) {
      print('PostPage: Error submitting post: $e'); // Debug log
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Error submitting post')),
        );
      }
    } finally {
      setState(() => _isPosting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              PostInputField(
                controller: _postController,
                onPickImage: _pickImage,
                selectedImage: _selectedImage,
              ),
              const SizedBox(height: 20),
              Center(
                child: AppButton(
                  text: _isPosting ? "Posting..." : "Post",
                  border: 20,
                  onTap: _isPosting ? null : _submitPost,
                ),
              ),
              const SizedBox(height: 20), // Add padding at the bottom
            ],
          ),
        ),
      ),
    );
  }
}