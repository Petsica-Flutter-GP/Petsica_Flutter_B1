import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/core/utils/snackbar_helper.dart';
import 'package:petsica/features/Login/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/phone_number_input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/circle_image_picker.dart';
import 'package:petsica/features/signup/presentation/widgets/verification_id_input_field.dart';
import 'package:petsica/services/signup/auth_service_clinic.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/app_button.dart';
import '../../../../../core/utils/app_arrow_back.dart';
import '../../../../Login/presentation/views/widgets/login_word.dart';
import '../../../../Login/presentation/views/widgets/password_field.dart';

class ClinicSignUpViewBody extends StatefulWidget {
  const ClinicSignUpViewBody({super.key});

  @override
  State<ClinicSignUpViewBody> createState() => _ClinicSignUpViewBodyState();
}

class _ClinicSignUpViewBodyState extends State<ClinicSignUpViewBody> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _clinicNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _workingHoursController = TextEditingController();
  final _locationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _verificationController = TextEditingController();

  File? _profileImage;
  File? _verificationImage;
  bool _isLoading = false;

  Future<void> _pickVerificationImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        SnackbarHelper.show(context, "No image selected", isError: true);
        return;
      }

      setState(() => _verificationImage = File(image.path));
      _verificationController.text = image.path.split('/').last;
      SnackbarHelper.show(context, "Image selected successfully",
          isError: false);
    } catch (error) {
      SnackbarHelper.show(context, "Error picking image: \${error.toString()}",
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
              _pickVerificationImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Upload From Gallery'),
            onTap: () {
              Navigator.pop(context);
              _pickVerificationImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _signUpClinic() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final clinicName = _clinicNameController.text.trim();
    final phone = _phoneNumberController.text.trim();
    final workingHours = _workingHoursController.text.trim();
    final location = _locationController.text.trim();
    final password = _passwordController.text.trim();

    if (_verificationImage == null) {
      SnackbarHelper.show(context, "Please select a verification image",
          isError: true);
      return;
    }

    setState(() => _isLoading = true);

    final result = await AuthServiceClinic.registerClinic(
      email: email,
      userName: clinicName,
      password: password,
      address: location,
      workingHours: workingHours,
      phone: phone,
      verificationImage: _verificationImage!,
      profileImage: _profileImage,
    );

    setState(() => _isLoading = false);

    SnackbarHelper.show(
      context,
      result["message"],
      isError: !result["success"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const AppArrowBack(destination: AppRouter.kWhoAreYou),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text("Sign Up",
                          style:
                              Styles.textStyleQu28.copyWith(color: kWordColor)),
                      const SizedBox(height: 8),
                      Text("Please enter the details to continue",
                          style: Styles.textStyleCom18
                              .copyWith(color: kWordColor)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 26),
                        CircleProfileImagePicker(
                          name: 'clinic',
                          image: _profileImage,
                          onImageSelected: (File? image) {
                            setState(() => _profileImage = image);
                            if (image != null) {
                              SnackbarHelper.show(context,
                                  "Profile picture updated successfully",
                                  isError: false);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          label: 'Email address',
                          controller: _emailController,
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                                  ? 'Required'
                                  : null,
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          label: "Clinic Name",
                          controller: _clinicNameController,
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                                  ? 'Required'
                                  : null,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: InputField(
                                label: "Working hours",
                                controller: _workingHoursController,
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                        ? 'Required'
                                        : null,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: PhoneNumberInputField(
                                label: "Phone Number",
                                controller: _phoneNumberController,
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
                          controller: _verificationController,
                          onSelectImage: (File? image) {
                            if (image != null) {
                              setState(() => _verificationImage = image);
                              _verificationController.text =
                                  image.path.split('/').last;
                              SnackbarHelper.show(
                                  context, "Image selected successfully",
                                  isError: false);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          label: 'Location',
                          icon: const Icon(Icons.place, color: kIconsColor),
                          controller: _locationController,
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                                  ? 'Required'
                                  : null,
                        ),
                        const SizedBox(height: 30),
                        PasswordField(
                          text: 'Password',
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 20),
                        AppButton(
                          text: _isLoading ? "Creating..." : "Create Account",
                          border: 20,
                          onTap: _isLoading ? null : _signUpClinic,
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
      ),
    );
  }
}
