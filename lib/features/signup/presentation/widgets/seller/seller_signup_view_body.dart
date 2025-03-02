import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/arrow_back.dart';

class SellerSignUpViewBody
 extends StatelessWidget {
  const SellerSignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seller Sign Up"),
                leading: ArrowBack()

      ),
      body: const Center(
        child: Text(
          'seller',
          style: TextStyle(color: Colors.black, fontSize: 70),
        ),
      ),
    );
  }
}
