import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/features/profiles/widgets/profile_list_tile.dart';

class AdminProfileMenu extends StatelessWidget {
  const AdminProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileListTile(
          iconasset: AssetData.navServices,
          label: 'Sitter requests',
          height: 55,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kAdminSitterRequests);
          },
        ),
        const SizedBox(height: 30),
        ProfileListTile(
          iconasset: AssetData.storeIcon,
          label: 'Seller requests',
          height: 33,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kAdminSellerRequests);
          },
        ),
        const SizedBox(height: 30),
        ProfileListTile(
          iconasset: AssetData.clinicIcon,
          label: 'Clinic requests',
          height: 40,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kAdminClinicRequests);
          },
        ),
        const SizedBox(height: 30),
        ProfileListTile(
          iconasset: AssetData.orderIcon,
          label: 'Orders',
          height: 50,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kChooseOrderScreen);
          },
        ),
        const SizedBox(height: 30),
        ProfileListTile(
          iconasset: AssetData.settingsIcon,
          label: 'Settings',
          height: 50,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kAdminSettings);
          },
        ),
        const SizedBox(height: 30),
        const ProfileListTile(
          iconasset: AssetData.aboutUsIcon,
          label: 'About us',
          height: 45,
        ),
        const SizedBox(height: 30),
        const ProfileListTile(
          iconasset: AssetData.logoutIcon,
          label: 'Log out',
          height: 37,
        ),
      ],
    );
  }
}
