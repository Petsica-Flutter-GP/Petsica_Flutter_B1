import 'package:flutter/material.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/sign_word.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/login_button.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/password_field.dart';

import '../../../../../core/constants.dart';

class WelcomeBackViewBody extends StatefulWidget {
  final String selectedOption; // ✅ استقبال الخيار المختار

  const WelcomeBackViewBody({super.key, required this.selectedOption});

  @override
  State<WelcomeBackViewBody> createState() => _WelcomeBackViewBodyState();
}

class _WelcomeBackViewBodyState extends State<WelcomeBackViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          Center(
            child: Column(
              children: [
                Text(
                  "Welcome Back , name!",
                  style: Styles.textStyleQu28.copyWith(color: kWordColor),
                ),
                const SizedBox(height: 8),
                Text(
                  "Please login to continue",
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
                child: Column(
                  children: [
                    const SizedBox(height: 37),
                    const InputField(label: 'User name'),
                    const SizedBox(height: 29),
                    const PasswordField(text: 'Password'),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget Password?",
                          style:
                              Styles.textStyleCom12.copyWith(color: kWordColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 33),
                    const AppButton(text: "Login", border: 20,),
                    SignupWord(
                        text1: "Don’t have an account?",
                        text2: "Sign Up",
                        userType: widget.selectedOption),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    
    );
  }
}
