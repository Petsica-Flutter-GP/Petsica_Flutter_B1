import 'package:flutter/material.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';
import 'package:petsica/features/Login/presentation/views/widgets/input_field.dart';

import '../../../../core/constants.dart';

class SitterEditServicesViewBody extends StatefulWidget {
  const SitterEditServicesViewBody({super.key});

  @override
  State<SitterEditServicesViewBody> createState() =>
      _SitterEditServicesViewBodyState();
}

class _SitterEditServicesViewBodyState
    extends State<SitterEditServicesViewBody> {
  String selectedType = 'Cat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteGroundColor,
        appBar: AppBar(
          title: Text("Edit Service", style: Styles.textStyleQu28),
          centerTitle: true,
          leading: const AppArrowBack(destination: AppRouter.kSitterMyServices),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const InputField(
                label: 'Sitter Name',
              ),
              const SizedBox(
                height: 30,
              ),
              const InputField(
                label: 'Price per hour',
              ),
              const SizedBox(
                height: 30,
              ),
              const InputField(
                label: 'Phone number',
              ),
              const SizedBox(
                height: 30,
              ),
              const InputField(
                label: 'Description (Optional) ',
              ),
              const SizedBox(
                height: 30,
              ),
              AppDropDownButton(
                labelText: 'Pet Type',
                items: const ['Cat', 'Dog', "both the same"],
                value: selectedType,
                onChanged: (newVal) {
                  setState(() {
                    selectedType = newVal!;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: AppButton(
                  text: 'Save changes',
                  border: 10,
                  width: 170,
                ),
              )
            ],
          ),
        ));
  }
}
