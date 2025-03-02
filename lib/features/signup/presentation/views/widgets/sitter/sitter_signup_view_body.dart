import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/arrow_back.dart';

import '../../../../../../core/utils/app_router.dart';

class SitterSignUpViewBody
 extends StatelessWidget {
  const SitterSignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sitter Sign Up"),
        leading: ArrowBack()
      ),
      body: const Center(
        child: Text(
          'sitter',
          style: TextStyle(color: Colors.black, fontSize: 70),
        ),
      ),
    );
  }
}
