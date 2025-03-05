import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petsica/core/utils/arrow_back.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/phone_number_input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/circle_image_picker.dart';
import 'package:petsica/features/signup/presentation/widgets/verification_id_input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/working_hours_input_field.dart';

import '../../../../../core/constants.dart';
import '../../../../registeration/presentation/views/widgets/login_button.dart';
import '../../../../registeration/presentation/views/widgets/login_word.dart';
import '../../../../registeration/presentation/views/widgets/password_field.dart';

class UserSignUpViewBody extends StatefulWidget {
  const UserSignUpViewBody({super.key});

  @override
  State<UserSignUpViewBody> createState() => _UserSignUpViewBodyState();
}

class _UserSignUpViewBodyState extends State<UserSignUpViewBody> {
  File? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const ArrowBack(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "Sign Up",
                  style: Styles.textStyleQu28.copyWith(color: kWordColor),
                ),
                const SizedBox(height: 8),
                Text(
                  "Please enter the details to continue",
                  style: Styles.textStyleCom18.copyWith(color: kWordColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 26),
                      CircleProfileImagePicker(
                        name: 'user',
                        image: _profileImage,
                        onImageSelected: (File? image) {
                          setState(() {
                            _profileImage = image;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const InputField(label: 'Email address'),
                      const SizedBox(height: 20),
                      const InputField(label: "User Name"),
                      const SizedBox(height: 20),
                      const PasswordField(text: 'Password'),
                      const SizedBox(height: 20),
                      const PasswordField(text: 'Confirm password'),
                      const SizedBox(height: 20),
                      const AppButton(text: "Create Account"),
                      const LoginWord(
                        text1: 'Already have an account?',
                        text2: 'Login',
                        userType: 'Pet Parent',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
