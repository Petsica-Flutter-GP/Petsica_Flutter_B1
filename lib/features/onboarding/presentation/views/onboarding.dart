import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/features/onboarding/presentation/views/widgets/onboarding_body.dart';
import '../../../../core/utils/asset_data.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      pages: [
        OnboardingBody(
          title: "Pet Parent 🐾❤️",
          description:
              "Find everything your furry friend needs, from trusted pet sitters to essential pet care services.",
          image: AssetData.oBparentImage,
          bgColor: kAppColor,
          textColor: kWordColor,
        ),
        OnboardingBody(
          title: "Pet Sitter 🏡🐾",
          description:
              "Connect with pet parents and offer your professional pet-sitting services with ease.",
          image: AssetData.oBsitterImage,
          bgColor: kAppColor,
          textColor: kWordColor,
        ),
        OnboardingBody(
          title: "Pet Seller 🛍️🐾",
          description:
              "Offer high-quality pet supplies and essentials to keep pets happy and healthy.",
          image: AssetData.oBsellerImage,
          bgColor: kAppColor,
          textColor: kWordColor,
        ),
        OnboardingBody(
          title: "Clinic 🏥🐾",
          description:
              "Provide top-quality veterinary care and services to ensure pets stay healthy and happy.",
          image: AssetData.oBclinicImage,
          bgColor: kAppColor,
          textColor: kWordColor,
        ),
      ],
    );
  }
}
