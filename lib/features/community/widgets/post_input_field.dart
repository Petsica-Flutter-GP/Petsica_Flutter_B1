import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';

class PostInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPickImage;
  final File? selectedImage;

  const PostInputField({
    super.key,
    required this.controller,
    required this.onPickImage,
    this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(AssetData.profileIcon),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: 5,
                minLines: 1,
                style: Styles.textStyleQui20.copyWith(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: "What's on your mind?",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onPickImage,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 10),
                Text(
                  selectedImage != null ? 'Image Selected' : 'Add Image',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
        if (selectedImage != null) ...[
          const SizedBox(height: 10),
          Container(
            constraints: BoxConstraints(
              maxHeight: 300, // Limit the image height to prevent overflow
              maxWidth: MediaQuery.of(context).size.width - 32, // Account for padding
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                selectedImage!,
                fit: BoxFit.contain, // Scale the image proportionally
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
      ],
    );
  }
}