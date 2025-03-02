import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/arrow_back.dart'; // ✅ تأكدي من استيراد go_router

class UserSignUpViewBody extends StatelessWidget {
  const UserSignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Sign Up"),
        leading: ArrowBack(),
      ),
      body: const Center(
        child: Text(
          'user',
          style: TextStyle(color: Colors.black, fontSize: 70),
        ),
      ),
    );
  }
}
