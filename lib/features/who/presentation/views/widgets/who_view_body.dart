import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/who/presentation/views/widgets/who_are_you_box.dart';

class WhoViewBody extends StatefulWidget {
  const WhoViewBody({super.key});

  @override
  State<WhoViewBody> createState() => _WhoViewBodyState();
}

class _WhoViewBodyState extends State<WhoViewBody> {
  String? selectedOption;

  void _navigateToWelcomeBack(String option) {
    setState(() {
      selectedOption = option;
    });

    context.go(AppRouter.kWelcomeBack,
        extra: option); // ✅ الانتقال إلى WelcomeBack
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 60),
          Text(
            'Who Are You?',
            style: Styles.textStyleQu28.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WhoAreYouBox(
                text: 'Pet Parent',
                image: AssetData.parentImage,
                onTap: () => _navigateToWelcomeBack('Pet Parent'),
              ),
              WhoAreYouBox(
                text: 'Pet Sitter',
                image: AssetData.sitterImage,
                onTap: () => _navigateToWelcomeBack('Pet Sitter'),
              ),
            ],
          ),
          const SizedBox(height: 55),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WhoAreYouBox(
                text: 'Clinic',
                image: AssetData.clinicImage,
                onTap: () => _navigateToWelcomeBack('Clinic'),
              ),
              WhoAreYouBox(
                text: 'Pet Seller',
                image: AssetData.sellerImage,
                onTap: () => _navigateToWelcomeBack('Pet Seller'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
