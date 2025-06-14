import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/logic/updateProfile/update_info_cubit.dart';
import 'package:petsica/features/profiles/logic/updateProfile/update_info_state.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _userNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _locationController = TextEditingController();
  final _photoController = TextEditingController();
  String? _selectedFileName;

  @override
  void dispose() {
    _userNameController.dispose();
    _addressController.dispose();
    _locationController.dispose();
    _photoController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final bytes = await picked.readAsBytes();
      final base64 = base64Encode(bytes);

      setState(() {
        _photoController.text = base64;
        _selectedFileName = File(picked.path).uri.pathSegments.last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdateProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          title: const Text("Edit Profile"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
            listener: (context, state) {
              if (state is UpdateProfileSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Profile updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              } else if (state is UpdateProfileFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('❌ ${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTextField(
                      label: 'Username',
                      controller: _userNameController,
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      label: 'Address',
                      controller: _addressController,
                      icon: Icons.home,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      label: 'Location',
                      controller: _locationController,
                      icon: Icons.location_on,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.image),
                          label: const Text("Select Photo"),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _selectedFileName ?? 'select image',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    state is UpdateProfileLoading
                        ? const CircularProgressIndicator()
                        : AppButton(
                            text: 'Save',
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<UpdateProfileCubit>(context)
                                  .updateProfile(
                                userName: _userNameController.text.trim(),
                                photo: _photoController.text.trim(), // Base64
                                address: _addressController.text.trim(),
                                location: _locationController.text.trim(),
                              );
                            },
                            border: 15,
                            style: Styles.textStyleQui20.copyWith(
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
