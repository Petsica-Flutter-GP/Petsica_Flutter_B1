import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/circle_image_picker.dart';
import 'package:petsica/features/signup/presentation/widgets/verification_id_input_field.dart';
import 'package:petsica/services/signup/auth_service_seller.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_arrow_back.dart';
import '../../../../registeration/presentation/views/widgets/login_word.dart';
import '../../../../registeration/presentation/views/widgets/password_field.dart';
import '../../../../../core/constants.dart';

class SellerSignUpViewBody extends StatefulWidget {
  const SellerSignUpViewBody({super.key});

  @override
  State<SellerSignUpViewBody> createState() => _SellerSignUpViewBodyState();
}

class _SellerSignUpViewBodyState extends State<SellerSignUpViewBody> {
  File? _profileImage;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUpSeller() async {
    String email = _emailController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await AuthServiceSeller.registerSeller(
      email: email,
      userName: username,
      password: password,
    );

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result["message"]),
        backgroundColor: result["success"] ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: AppArrowBack(destination: AppRouter.kWhoAreYou),
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
                        name: 'seller',
                        image: _profileImage,
                        onImageSelected: (File? image) {
                          setState(() {
                            _profileImage = image;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        label: 'Email address',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        label: "User Name",
                        controller: _usernameController,
                      ),
                      const SizedBox(height: 20),
                      PasswordField(
                        text: 'Password',
                        controller: _passwordController,
                      ),const SizedBox(height: 20),
                      VerificationIdInputField(
                        label: 'National ID',
                        onSelectImage: () {},
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : AppButton(
                              text: "Create Account",
                              border: 20,
                              onTap: _signUpSeller,
                            ),
                      const SizedBox(height: 20),
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
            ),
          ),
        ],
      ),
    );
  }
}
