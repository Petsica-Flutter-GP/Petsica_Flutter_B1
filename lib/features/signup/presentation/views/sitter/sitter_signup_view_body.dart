import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/circle_image_picker.dart';
import 'package:petsica/features/signup/presentation/widgets/verification_id_input_field.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/app_button.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_arrow_back.dart';
import '../../../../../services/signup/auth_service_sitter.dart';
import '../../../../registeration/presentation/views/widgets/login_word.dart';
import '../../../../registeration/presentation/views/widgets/password_field.dart';

class SitterSignUpViewBody extends StatefulWidget {
  const SitterSignUpViewBody({super.key});

  @override
  State<SitterSignUpViewBody> createState() => _SitterSignUpViewBodyState();
}

class _SitterSignUpViewBodyState extends State<SitterSignUpViewBody> {
  File? _profileImage;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;

  Future<void> _signUpSitter() async {
    print("Attempting sitter sign-up...");
    String email = _emailController.text.trim();
    String username = _usernameController.text.trim();
    String nationalId = _idController.text.trim();
    String location = _locationController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty ||
        username.isEmpty ||
        nationalId.isEmpty ||
        location.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      setState(() => _isLoading = true);

      final result = await AuthServiceSitter.registerSitter(
        email: email,
        userName: username,
        nationalId: nationalId,
        location: location,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(result["message"]),
            backgroundColor: result["success"] ? Colors.green : Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,


        leading:const AppArrowBack(destination: AppRouter.kWhoAreYou),

      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text("Sign Up",
                      style: Styles.textStyleQu28.copyWith(color: kWordColor)),
                  const SizedBox(height: 8),
                  Text("Please enter the details to continue",
                      style: Styles.textStyleCom18.copyWith(color: kWordColor)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
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
                        setState(() => _profileImage = image);
                      },
                    ),
                    const SizedBox(height: 20),
                    InputField(
                        label: 'Email address', controller: _emailController),
                    const SizedBox(height: 20),
                    InputField(
                        label: "User Name", controller: _usernameController),
                    const SizedBox(height: 20),
                    VerificationIdInputField(
                        label: 'National ID',
                        onSelectImage: () {},
                        controller: _idController),
                    const SizedBox(height: 20),
                    InputField(
                        label: 'Location',
                        controller: _locationController,
                        icon: const Icon(Icons.place, color: kIconsColor)),
                    const SizedBox(height: 20),
                    PasswordField(
                        text: 'Password', controller: _passwordController),
                    const SizedBox(height: 20),
                    PasswordField(
                        text: 'Confirm password',
                        controller: _confirmPasswordController),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : AppButton(
                            text: "Create Account",
                            border: 20,
                            onTap: _signUpSitter,
                          ),
                    const SizedBox(height: 20),
                    const LoginWord(
                        text1: 'Already have an account?',
                        text2: 'Login',
                        userType: 'Pet Sitter'),
                    const SizedBox(height: 40),
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
