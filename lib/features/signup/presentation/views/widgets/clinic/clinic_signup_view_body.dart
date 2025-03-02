import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/arrow_back.dart';

class ClinicSignUpViewBody extends StatelessWidget {
  const ClinicSignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("clinic Sign Up"),
               leading: ArrowBack()

      ),
      body: const Center(
        child: Text(
          'clinic',
          style: TextStyle(color: Colors.black, fontSize: 70),
        ),
      ),
    );
  }
}
