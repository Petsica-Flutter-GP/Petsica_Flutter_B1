import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/sign_up_arrow_back.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/phone_number_input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/circle_image_picker.dart';
import 'package:petsica/features/signup/presentation/widgets/verification_id_input_field.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/utils/app_button.dart';
import '../../../../registeration/presentation/views/widgets/login_word.dart';
import '../../../../registeration/presentation/views/widgets/password_field.dart';

class SellerSignUpViewBody extends StatefulWidget {
  const SellerSignUpViewBody({super.key});

  @override
  State<SellerSignUpViewBody> createState() => _SellerSignUpViewBodyState();
}

class _SellerSignUpViewBodyState extends State<SellerSignUpViewBody> {
  File? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: AppArrowBack(destination: AppRouter.kWhoAreYou),
          ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // تمرير سلس
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
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
            Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    const PhoneNumberInputField(label: 'Phone number'),
                    const SizedBox(height: 20),
                    VerificationIdInputField(
                      label: 'National ID',
                      onSelectImage: () {},
                    ),
                    const SizedBox(height: 20),
                    const PasswordField(text: 'Password'),
                    const SizedBox(height: 20),
                    const PasswordField(text: 'Confirm password'),
                    const SizedBox(height: 20),
                    const AppButton(
                      text: "Create Account",
                      border: 20,
                    ),
                    const LoginWord(
                      text1: 'Already have an account?',
                      text2: 'Login',
                      userType: 'Pet Seller',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
