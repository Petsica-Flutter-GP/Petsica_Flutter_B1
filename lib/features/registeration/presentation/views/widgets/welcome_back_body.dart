import 'package:flutter/material.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/log_or_sign_word.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/login_button.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/password_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants.dart';

class WelcomeBackBody extends StatefulWidget {
  const WelcomeBackBody({super.key});

  @override
  State<WelcomeBackBody> createState() => _WelcomeBackBodyState();
}

class _WelcomeBackBodyState extends State<WelcomeBackBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // ✅ يجعل العناصر تبدأ من الأعلى
          crossAxisAlignment:
              CrossAxisAlignment.center, // ✅ توسيط العناصر أفقيًا
          children: [
            const SizedBox(height: 40), // ✅ مسافة من الأعلى
            Center(
              child: Column(
                children: [
                  Text(
                    "Welcome Back !",
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

            // ✅ الحاوية تأخذ كل المساحة المتبقية من الأسفل
            Expanded(
              child: Container(
                width: double.infinity, // ✅ تأخذ عرض الشاشة بالكامل
                alignment: Alignment.center, // ✅ توسيط المحتوى بداخلها
                decoration: const BoxDecoration(
                  color: Colors.white, // ✅ لون الخلفية
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30), // ✅ حواف مستديرة فقط من الأعلى
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 37),
                      const InputField(text: 'User name'),
                      const SizedBox(height: 29),
                      const PasswordField(text: 'Password'),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget Password?",
                            style: Styles.textStyleCom12
                                .copyWith(color: kWordColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 33),
                      const AppButton(text: "Login"),
                      const Log_Sign(
                          text1: "Don’t have an account?", text2: "Sign Up"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
