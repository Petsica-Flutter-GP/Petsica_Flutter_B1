import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/features/profiles/widgets/logout_service.dart';
import 'package:petsica/features/profiles/widgets/profile_list_tile.dart';

class ClinicProfileMenu extends StatelessWidget {
  const ClinicProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ProfileListTile(
            iconasset: AssetData.clinicIcon,
            label: 'My clinic',
            height: 40,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ProfileListTile(
            iconasset: AssetData.petIcon,
            label: 'Add Pet',
            height: 50,
            onTap: () {
              GoRouter.of(context).go(AppRouter.kMyPet);
              print("clinic add pet");
            }),
        const SizedBox(
          height: 30,
        ),
        ProfileListTile(
          iconasset: AssetData.settingsIcon,
          label: 'Settings',
          height: 50,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kClinicSettings);
          },
        ),
        const SizedBox(
          height: 30,
        ),
        const ProfileListTile(
          iconasset: AssetData.aboutUsIcon,
          label: 'About us',
          height: 45,
        ),
        const SizedBox(
          height: 30,
        ),
        ProfileListTile(
          iconasset: AssetData.logoutIcon,
          label: 'Log out',
          height: 37,
          onTap: () async {
            await revokeRefreshToken();
            await TokenStorage.clearTokens();
            GoRouter.of(context).go(AppRouter.kWelcomeBack);
          },
        ),
      ],
    );
  }
}
