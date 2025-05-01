import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/logic/add_pet_cubit.dart';
import 'package:petsica/features/profiles/logic/add_pet_state.dart';
import 'package:petsica/features/profiles/model/pet_model.dart';
import 'package:petsica/features/profiles/seller/widget/seller_camera_placeholder.dart';
import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import '../../../../core/utils/app_arrow_back.dart';

class AddPetPageViewBody extends StatefulWidget {
  const AddPetPageViewBody({super.key});

  @override
  State<AddPetPageViewBody> createState() => _AddPetPageViewBodyState();
}

class _AddPetPageViewBodyState extends State<AddPetPageViewBody> {
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petAgeController = TextEditingController();

  String selectedType = 'Cat';
  String selectedGender = 'Female';

  final _formKey = GlobalKey<FormState>();
  bool isImageRequired = false;
  bool isLoading = false;

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteGroundColor,
      appBar: AppBar(
        title: Text("Add Your Pet Information", style: Styles.textStyleQui24),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kUserMyPet),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SellerCameraPlaceholder(
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
              const SizedBox(height: 40),
              InputField(
                label: 'Pet Name',
                controller: _petNameController,
              ),
              const SizedBox(height: 25),
              InputField(
                label: "Pet Age",
                controller: _petAgeController,
              ),
              const SizedBox(height: 25),
              AppDropDownButton(
                labelText: 'Pet Type',
                items: const ['Cat', 'Dog'],
                value: selectedType,
                onChanged: (newVal) {
                  setState(() {
                    selectedType = newVal!;
                  });
                },
              ),
              const SizedBox(height: 25),
              AppDropDownButton(
                labelText: 'Pet Gender',
                items: const ['Male', 'Female'],
                value: selectedGender,
                onChanged: (newVal) {
                  setState(() {
                    selectedGender = newVal!;
                  });
                },
              ),
              const SizedBox(height: 60),
              BlocConsumer<AddPetCubit, AddPetState>(
                listener: (context, state) {
                  if (state is AddPetSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('✔️ Pet added successfully')),
                    );
                  } else if (state is AddPetFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is AddPetLoading;

                  return Align(
                    alignment: Alignment.bottomRight,
                    child: AppButton(
                      text: isLoading ? 'Adding...' : 'Add',
                      border: 10,
                      width: 100,
                      backgroundColor: kProducPriceColor,
                      onTap: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (_selectedImage == null) {
                            setState(() {
                              isImageRequired = true;
                            });
                            return;
                          }

                          final bytes = await _selectedImage!.readAsBytes();
                          final base64Image = base64Encode(bytes);

                          final pet = PetModel(
                            species: _petAgeController.text,
                            photo: base64Image,
                            gender: selectedGender,
                            name: _petNameController.text,
                            breed: selectedType,
                          );

                          context.read<AddPetCubit>().addPet(pet);
                        }
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
