import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/widgets/app_switch.dart';

class PetDetailsViewBody extends StatelessWidget {
  const PetDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // 🐾 بيانات الحيوان الأليف ثابتة هنا
    const petName = "Luna";
    const petImage = AssetData.petImage;
    const petAge = "2";
    const petGender = "Female";
    const petType = "Cat";

    return Scaffold(
      backgroundColor: kWhiteGroundColor,
      appBar: AppBar(
        title: Text(petName, style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(
          destination: AppRouter.kMyPet,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                petImage,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfo("Name", petName),
                _buildInfo("Type", petType),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfo("Age", petAge),
                _buildInfo("Gender", petGender),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Adoption",
                      style: Styles.textStyleCom28
                          .copyWith(color: kAddPetTextColor),
                    ),
                    const Spacer(),
                    const AppSwitch()
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Mating",
                      style: Styles.textStyleCom28
                          .copyWith(color: kAddPetTextColor),
                    ),
                    const Spacer(),
                    const AppSwitch()
                  ],
                ),
                const Text(
                  'User',
                  style: TextStyle(fontSize: 40),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: AppButton(
                text: 'Edit',
                border: 10,
                backgroundColor: kProducPriceColor,
                width: 120,
                style: Styles.textStyleQui24.copyWith(color: Colors.white),
                onTap: () {
                  // ⚠️ لا يتم تمرير pet لأننا نستخدم بيانات ثابتة
                  GoRouter.of(context).go(AppRouter.kEditPet);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget _buildInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.textStyleCom28.copyWith(color: kAddPetTextColor),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Styles.textStyleCom22,
        ),
      ],
    );
  }
}
