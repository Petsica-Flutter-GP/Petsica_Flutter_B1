import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/features/profiles/widgets/profile_list_tile.dart';

class SellerProfileMenu extends StatelessWidget {
  const SellerProfileMenu();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileListTile(
          iconasset: AssetData.orderIcon,
          label: 'My order',
          height: 50,
          onTap: () {
            GoRouter.of(context).go(
              AppRouter.kSellerOrders,
            );
          },
        ),
        const SizedBox(height: 30),
        ProfileListTile(
          iconasset: AssetData.storeIcon,
          label: 'My store',
          height: 35,
          onTap: () {
            GoRouter.of(context).go(
              AppRouter.kSellerMyStore,
            );
          },
        ),
        const SizedBox(height: 30),
        ProfileListTile(
            iconasset: AssetData.petIcon,
            label: 'Add Pet',
            height: 50,
            onTap: () {
              GoRouter.of(context).go(AppRouter.kMyPet);
              print("seller add pet");
            }),
        const SizedBox(height: 30),
        ProfileListTile(
          iconasset: AssetData.settingsIcon,
          label: 'Settings',
          height: 50,
          onTap: () {
            GoRouter.of(context).go(AppRouter.kSellerSettings);
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
