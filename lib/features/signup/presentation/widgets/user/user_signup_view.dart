import 'package:flutter/material.dart';
import 'package:petsica/features/signup/presentation/widgets/user/user_signup_view_body.dart';

class UserSignUpView extends StatelessWidget {
  const UserSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserSignUpViewBody(),
    );
  }
}
