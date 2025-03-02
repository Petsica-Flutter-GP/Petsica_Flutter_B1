import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petsica/core/utils/arrow_back.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/login_button.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/login_word.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/password_field.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/phone_number_input_field.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/verification_id_input_field.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/working_hours_input_field.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/styles.dart';

class ClinicSignUpViewBody extends StatelessWidget {
  const ClinicSignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Clinic Sign Up"),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const InputField(label: 'User name'),
                      const SizedBox(height: 20),
                      const PasswordField(text: 'Password'),
                      const SizedBox(height: 20),
                      const InputField(label: "Clinic Name"),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Expanded(
                            child: WorkingHoursField(
                              label: "Working hours",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: PhoneNumberInputField(
                              label: "Phone Number",
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
                      const VerificationIDField(),
                      const SizedBox(height: 30),
                      const AppButton(text: "Create Account"),
                      const LoginWord(
                          text1: 'Already have an account?',
                          text2: 'Login',
                          userType: 'Clinic')
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
