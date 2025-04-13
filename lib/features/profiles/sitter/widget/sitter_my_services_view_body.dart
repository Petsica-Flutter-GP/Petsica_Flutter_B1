import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_floating_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/sitter/widget/sitter_services_card.dart';

import '../../../../core/constants.dart';

class SitterMyServicesViewBody extends StatelessWidget {
  const SitterMyServicesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AppFloatingButton(
        color: kProducPriceColor,
        icon: const Icon(
          Icons.add,
          size: 35,
          color: kWhiteGroundColor,
        ),
        onPressed: () {
          GoRouter.of(context).go(
            AppRouter.kSitterNewServices,
          );
        },
      ),
      backgroundColor: kWhiteGroundColor,
      appBar: AppBar(
        title: Text("My Services", style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kSitterProfile),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 4, // عدديهم حسب الحاجة
        itemBuilder: (context, index) {
          return const SitterCard();
        },
      ),
    );
  }
}
