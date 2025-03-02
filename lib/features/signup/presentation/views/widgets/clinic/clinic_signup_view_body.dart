import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/upload_id.dart';

import '../../../../../../core/utils/arrow_back.dart';
import '../../../../../../core/utils/styles.dart';

class ClinicSignUpViewBody extends StatelessWidget {
  const ClinicSignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("clinic Sign Up"),
        leading: const ArrowBack(),
      ),
      body: Column(
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
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 26),
                    child: ProfilePicture(
                        name: 'user user', radius: 55, fontsize: 36),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
