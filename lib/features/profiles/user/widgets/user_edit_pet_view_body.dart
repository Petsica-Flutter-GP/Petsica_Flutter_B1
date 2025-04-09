import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';
import 'package:petsica/features/profiles/widgets/pet_camera_placeholder.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/signup/presentation/widgets/circle_image_picker.dart';

import '../../../../core/utils/app_arrow_back.dart';

class UserEditPetPageViewBody extends StatelessWidget {
  const UserEditPetPageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteGroundColor,
      appBar: AppBar(
        title: Text("Edit Your Pet Informantion", style: Styles.textStyleQui24),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kUserPetDetails),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            PetCameraPlaceholder(),
            SizedBox(
              height: 40,
            ),
            InputField(label: "Pet name"),
            SizedBox(
              height: 25,
            ),
            InputField(label: "Description (Optional)"),
            SizedBox(
              height: 25,
            ),
            PetTypeDropdown(
              labelText: 'Pet Type',
            ),
          ],
        ),
      ),
    );
  }
}
