import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/Login/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/signup/custom_snack_bar.dart';
import 'package:petsica/features/signup/presentation/widgets/circle_image_picker.dart';
import 'package:petsica/features/signup/presentation/widgets/otp_confirm.dart';
import 'package:petsica/features/signup/presentation/widgets/verification_id_input_field.dart';
import 'package:petsica/services/signup/auth_service_seller.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_arrow_back.dart';
import '../../../../Login/presentation/views/widgets/login_word.dart';
import '../../../../Login/presentation/views/widgets/password_field.dart';
import '../../../../../core/constants.dart';

class SellerSignUpViewBody extends StatefulWidget {
  const SellerSignUpViewBody({super.key});

  @override
  State<SellerSignUpViewBody> createState() => _SellerSignUpViewBodyState();
}

class _SellerSignUpViewBodyState extends State<SellerSignUpViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _profileImage;
  File? _nationalIdImage;
  String? _nationalIdBase64;
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUpSeller() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (_nationalIdBase64 == null) {
      showCustomSnackBar(context, "National ID photo is required");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await AuthServiceSeller.registerSeller(
        email: email,
        userName: username,
        password: password,
        nationalId: _nationalIdBase64!, // Sending base64-encoded image as nationalId
      );

      setState(() => _isLoading = false);

      if (result["success"]) {
        // Navigate to OTP confirmation page with the email
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpConfirmPage(email: email),
          ),
        );
      } else {
        showCustomSnackBar(
          context,
          result["message"],
          success: false,
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      showCustomSnackBar(
        context,
        "Error: $e",
        success: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const AppArrowBack(destination: AppRouter.kWhoAreYou),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Text("Sign Up", style: Styles.textStyleQu28.copyWith(color: kWordColor)),
                const SizedBox(height: 8),
                Text("Please enter the details to continue", style: Styles.textStyleCom18.copyWith(color: kWordColor)),
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
                  child: Form(
                    key: _formKey,
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return 'Required';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          label: "User Name",
                          controller: _usernameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return 'Required';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        PasswordField(
                          text: 'Password',
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 20),
                        VerificationIdInputField(
                          label: 'National ID',
                          controller: _nationalIdController,
                          onSelectImage: (File? image) async {
                            if (image != null) {
                              final bytes = await image.readAsBytes();
                              setState(() {
                                _nationalIdImage = image;
                                _nationalIdBase64 = base64Encode(bytes);
                              });
                            }
                          },
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
          ),
        ],
      ),
    );
  }
}