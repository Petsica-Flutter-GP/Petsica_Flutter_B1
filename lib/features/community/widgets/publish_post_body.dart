import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/features/community/widgets/post_input_field.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kAppColor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            // PostInputField(),
            PostInputField(),
            SizedBox(height: 20),
            Center(
              child: AppButton(
                text: "Post",
                border: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
