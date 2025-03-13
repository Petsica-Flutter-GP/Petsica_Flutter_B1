import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsica/core/utils/sign_up_arrow_back.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/core/utils/snackbar_helper.dart'; // ✅ استيراد SnackbarHelper
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/phone_number_input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/circle_image_picker.dart';
import 'package:petsica/features/signup/presentation/widgets/verification_id_input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/working_hours_input_field.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/app_button.dart';
import '../../../../registeration/presentation/views/widgets/login_word.dart';
import '../../../../registeration/presentation/views/widgets/password_field.dart';

class ClinicSignUpViewBody extends StatefulWidget {
  const ClinicSignUpViewBody({super.key});

  @override
  State<ClinicSignUpViewBody> createState() => _ClinicSignUpViewBodyState();
}

class _ClinicSignUpViewBodyState extends State<ClinicSignUpViewBody> {
  File? _profileImage;
  File? _verificationImage; // لتخزين صورة التحقق

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        SnackbarHelper.show(context, "No image selected", isError: true);
        return;
      }

      setState(() => _verificationImage = File(image.path));

      // ✅ عرض رسالة نجاح عند اختيار صورة
      SnackbarHelper.show(context, "Image selected successfully",
          isError: false);
    } catch (error) {
      // ✅ عرض رسالة خطأ عند الفشل في اختيار الصورة
      SnackbarHelper.show(context, "Error picking image: ${error.toString()}",
          isError: true);
    }
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take a Photo'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Upload From Gallery'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const SignUpArrowBack(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
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

                          if (image != null) {
                            SnackbarHelper.show(
                                context, "Profile picture updated successfully",
                                isError: false);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      const InputField(label: 'Email address'),
                      const SizedBox(height: 20),
                      const InputField(label: "Clinic Name"),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Expanded(
                            child: WorkingHoursField(label: "Working hours"),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: PhoneNumberInputField(
                              label: "Phone Number",
                              inputType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      VerificationIdInputField(
                        label: "Verification ID",
                        onSelectImage: () {
                          _showImageSourceDialog(context);
                        },
                      ),
                      const SizedBox(height: 20),
                      const InputField(
                        label: 'Location',
                        icon: Icon(Icons.place, color: kIconsColor),
                      ),
                      const SizedBox(height: 30),
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
                        userType: 'Clinic',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
