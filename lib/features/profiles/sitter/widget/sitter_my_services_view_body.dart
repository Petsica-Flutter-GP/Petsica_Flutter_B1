import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_floating_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/sitter/widget/sitter_services_card.dart';

import '../../../../core/constants.dart';

class SitterMyServicesViewBody extends StatelessWidget {
  const SitterMyServicesViewBody({super.key});

  final List<Service> services = const [
    Service(
      headline: 'Full-Day Pet Sitting',
      serviceType: 'Dogs',
      price: '\$20 / hour',
      image: AssetData.profileImage,
    ),
    Service(
      headline: 'Cat Grooming',
      serviceType: 'Cats',
      price: '\$15 / hour',
      image: AssetData.profileImage,
    ),
    Service(
      headline: 'Dog Walking',
      serviceType: 'Dogs',
      price: '\$10 / hour',
      image: AssetData.profileImage,
    ),
    Service(
      headline: 'Overnight Pet Care',
      serviceType: 'Dogs & Cats',
      price: '\$25 / hour',
      image: AssetData.profileImage,
    ),
  ];

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
          GoRouter.of(context).go(AppRouter.kSitterNewServices);
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
        itemCount: services.length,
        itemBuilder: (context, index) {
          return SitterCard(service: services[index]);
        },
      ),
    );
  }
}
