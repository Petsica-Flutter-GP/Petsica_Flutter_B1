import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/logic/addPet/add_pet_cubit.dart';
import 'package:petsica/features/profiles/logic/addPet/add_pet_state.dart';
import 'package:petsica/features/profiles/model/post_pet_model.dart';
import 'package:petsica/features/profiles/seller/widget/seller_camera_placeholder.dart';
import 'package:petsica/features/profiles/widgets/adoption_mating_tog.dart';
import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';
import 'package:petsica/features/profiles/widgets/app_switch.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import '../../../core/utils/app_arrow_back.dart';

class AddPetPageViewBody extends StatefulWidget {
  const AddPetPageViewBody({super.key});

  @override
  State<AddPetPageViewBody> createState() => _AddPetPageViewBodyState();
}

class _AddPetPageViewBodyState extends State<AddPetPageViewBody> {
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petAgeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String selectedType = 'Cat';
  String selectedGender = 'Female';

  bool isImageRequired = false;
  bool isLoading = false;
  File? _selectedImage;
  bool isAvailableForAdoption = false;
  bool isAvailableForMating = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPetCubit(),
      child: BlocConsumer<AddPetCubit, AddPetState>(
        listener: (context, state) {
          if (state is AddPetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✔️ Pet added successfully')),
            );

            _petNameController.clear();
            _petAgeController.clear();
            setState(() {
              _selectedImage = null;
              selectedType = 'Cat';
              selectedGender = 'Female';
            });

            GoRouter.of(context).go(AppRouter.kMyPet);
          } else if (state is AddPetFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('❌ ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddPetCubit>();

          return Scaffold(
            backgroundColor: kWhiteGroundColor,
            appBar: AppBar(
              title: Text("Add Your Pet Information",
                  style: Styles.textStyleQui24),
              centerTitle: true,
              leading: const AppArrowBack(destination: AppRouter.kMyPet),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ تأثير التفاعل عند اختيار الصورة
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedImage != null
                              ? Colors.green
                              : Colors.transparent,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SellerCameraPlaceholder(
                        color: kLightAddContainerColor,
                        onImageSelected: (image) {
                          setState(() {
                            _selectedImage = image;
                            isImageRequired = false;
                          });
                        },
                        onImageStatusChanged: (bool isSelected) {
                          setState(() {
                            isImageRequired = !isSelected;
                          });
                        },
                        isImageRequired: isImageRequired,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // 🐾 اسم الحيوان + الملاحظة
                    InputField(
                      color: kProducPriceColor,
                      label: 'Pet Name',
                      controller: _petNameController,
                      validator: (value) {
                        if (value!.isEmpty) return 'Required';
                        if (RegExp(r'[^a-zA-Z0-9\s]').hasMatch(value)) {
                          return 'Name should not contain symbols';
                        }

                        return null;
                      },
                      maxLength: 20,
                    ),

                    const SizedBox(height: 15),

                    InputField(
                      color: kProducPriceColor,
                      label: "Pet Age",
                      controller: _petAgeController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        final age = int.tryParse(value);
                        if (age == null || age <= 0) {
                          return 'Enter a valid age';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: AppDropDownButton(
                            color: kProducPriceColor,
                            labelText: 'Pet Type',
                            items: const ['Cat', 'Dog'],
                            value: selectedType,
                            onChanged: (newVal) {
                              setState(() {
                                selectedType = newVal!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppDropDownButton(
                            color: kProducPriceColor,
                            labelText: 'Pet Gender',
                            items: const ['Male', 'Female'],
                            value: selectedGender,
                            onChanged: (newVal) {
                              setState(() {
                                selectedGender = newVal!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        children: [
                          AdoptionOrMatongToggle(
                              text: "Available for Adoption"),
                          SizedBox(height: 10),
                          AdoptionOrMatongToggle(text: "Available for Mating")
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: AppButton(
                        text: isLoading ? 'Adding...' : 'Add',
                        border: 10,
                        width: 100,
                        backgroundColor: kProducPriceColor,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedImage == null) {
                              setState(() {
                                isImageRequired = true;
                              });
                              return;
                            }

                            final bytes = await _selectedImage!.readAsBytes();
                            final base64Image = base64Encode(bytes);

                            setState(() {
                              isLoading = true;
                            });

                            await cubit.addPet(
                              PetModel(
                                name: _petNameController.text.trim(),
                                age: _petAgeController.text.trim(),
                                type: selectedType,
                                gender: selectedGender,
                                photo: base64Image,
                              ),
                            );

                            setState(() {
                              isLoading = false;
                            });
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.red.shade600,
                              duration: const Duration(seconds: 2),
                              content: Row(
                                children: [
                                  const Icon(Icons.warning_amber_rounded,
                                      color: Colors.white),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Failed to add pet.. !!',
                                      style: Styles.textStyleCom16.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
