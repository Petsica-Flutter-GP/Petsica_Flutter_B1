
import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';
import 'package:petsica/features/profiles/widgets/pet_camera_placeholder.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';

import '../../../../core/utils/app_arrow_back.dart';

class UserEditPetPageViewBody extends StatefulWidget {
  const UserEditPetPageViewBody({super.key});

  @override
  State<UserEditPetPageViewBody> createState() =>
      _UserEditPetPageViewBodyState();
}

class _UserEditPetPageViewBodyState extends State<UserEditPetPageViewBody> {
  String selectedPetName = 'Cat';
  String selectedType = 'Cat';
  String selectedGender = 'Female';
  String selectedAge = '1';

  final _formKey = GlobalKey<FormState>(); // مفتاح الفورم

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteGroundColor,
      appBar: AppBar(
        title: Text("Edit Your Pet Information", style: Styles.textStyleQui24),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kUserPetDetails),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const PetCameraPlaceholder(),
              const SizedBox(height: 40),
              AppDropDownButton(
                labelText: 'Pet Name',
                items: const ['Cat', 'Dog', 'Rabbit', 'Bird'],
                value: selectedPetName,
                onChanged: (newVal) {
                  setState(() {
                    selectedPetName = newVal!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a pet name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              const InputField(label: "Description (Optional)"),
              const SizedBox(height: 25),
              const InputField(label: "Pet Age"),
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
              //   ElevatedButton(
              //     onPressed: () {
              //       if (_formKey.currentState!.validate()) {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           const SnackBar(content: Text('Saving pet info...')),
              //         );
              //       }
              //     },
              //     style: ElevatedButton.styleFrom(
              //       padding: const EdgeInsets.symmetric(vertical: 15),
              //       backgroundColor: kProducPriceColor,
              //       textStyle: const TextStyle(fontSize: 18),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     child: const Text('Save'),
              //   ),
              const Align(
                alignment: Alignment.bottomRight,
                child: AppButton(
                  text: 'Save edits',
                  border: 10,
                  width: 150,
                  backgroundColor: kProducPriceColor,
                ),
              ),
              const Text(
                'user',
                style: TextStyle(fontSize: 40),
              )
            ],
          ),
        ),
      ),
    );
  }
}
