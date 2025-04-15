import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';


class ChatBootOnboardingViewBody extends StatelessWidget {
  const ChatBootOnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kChatBackGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              AssetData.chatBootImage,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome To ',
                    style: Styles.textStyleCom32.copyWith(color: kBurgColor),
                  ),
                  Text(
                    'Petsica Ai',
                    style: Styles.textStyleCom34D.copyWith(color: kBurgColor),
                  )
                ],
              ),
            ),
            Text('Your own AI assistant',
                style: Styles.textStyleCom28.copyWith(color: kBurgColor)),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Text(
                    'Iam Presica-Ai, your AI-powered sustainability assistant. \nFeel free to ask me any questions you may have, and I will do my best to provide accurate and useful information to support you advancing your sustainability journey.',
                    style: Styles.textStyleCom18.copyWith(color: kBurgColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            AppButton(
                text: 'Get Started',
                border: 20,
                width: 350,
                backgroundColor: kWhiteGroundColor,
                style: Styles.textStyleQui20.copyWith(color: kBurgColor),
                borderColor: kBurgColor,
                onTap: () {
                  GoRouter.of(context).go(
                    AppRouter.kChatBoot,
                  );
                })
          ],
        ),
      ),
    );
  }
}
