import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
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
    final picked =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
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
      print(
          'PostPage: Image Base64 length: ${base64Image.length}'); // Debug log

      final success = await PostService.addPost(
        content: content,
        imageBase64: base64Image,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(success ? '✅ Post submitted!' : '❌ Failed to post')),
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
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: kAppColor,
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const SizedBox(height: 50),
  //             PostInputField(
  //               controller: _postController,
  //               onPickImage: _pickImage,
  //               selectedImage: _selectedImage,
  //             ),
  //             const SizedBox(height: 20),
  //             Center(
  //               child: AppButton(
  //                 text: _isPosting ? "Posting..." : "Post",
  //                 border: 20,
  //                 onTap: _isPosting ? null : _submitPost,
  //               ),
  //             ),
  //             const SizedBox(height: 20), // Add padding at the bottom
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Post',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: kBurgColor,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: kAppColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // حقل الإدخال
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: PostInputField(
                  controller: _postController,
                  onPickImage: _pickImage,
                  selectedImage: _selectedImage,
                ),
              ),

              const SizedBox(height: 25),

              // عرض الصورة المصغرة إذا تم اختيار صورة
              if (_selectedImage != null)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      _selectedImage!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              const SizedBox(height: 30),

              // زر النشر
              Center(
                child: SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isPosting ? null : _submitPost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBurgColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 6,
                      shadowColor: Colors.black26,
                    ),
                    child: _isPosting
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text("Posting...",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ],
                          )
                        : const Text("Post",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
