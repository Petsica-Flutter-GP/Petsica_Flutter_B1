import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';
import 'package:petsica/features/profiles/widgets/pet_camera_placeholder.dart';
import 'package:petsica/features/Login/presentation/views/widgets/input_field.dart';

import '../../../../core/utils/app_arrow_back.dart';

class SellerAddPetPageViewBody extends StatefulWidget {
  const SellerAddPetPageViewBody({super.key});

  @override
  State<SellerAddPetPageViewBody> createState() =>
      _SellerAddPetPageViewBodyState();
}

class _SellerAddPetPageViewBodyState extends State<SellerAddPetPageViewBody> {
  String selectedPetName = 'Cat';
  String selectedType = 'Cat';
  String selectedGender = 'Female';
  String selectedAge = '1';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteGroundColor,
      appBar: AppBar(
        title:
            Text("Si Add Your Pet Information", style: Styles.textStyleQui24),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kSellerMyPet),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const PetCameraPlaceholder(),
              const SizedBox(height: 40),
              const InputField(label: 'Pet Name'),
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
              const Align(
                alignment: Alignment.bottomRight,
                child: AppButton(
                  text: 'Add',
                  border: 10,
                  width: 100,
                  backgroundColor: kProducPriceColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
