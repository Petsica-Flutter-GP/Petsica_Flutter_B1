import 'package:flutter/material.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';
import 'package:petsica/features/profiles/widgets/app_switch.dart';
import 'package:petsica/features/profiles/widgets/profile_list_tile.dart';

import '../../../../core/constants.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedType = 'En';

    return Scaffold(
      backgroundColor: kWhiteGroundColor,
      appBar: AppBar(
        title: Text("Admin Settings", style: Styles.textStyleQui28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kAdminProfile),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            // ✅ صورة الإعدادات
            SizedBox(
              height: 300,
              child: Image.asset(
                AssetData.settingImage,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 40),
            const Divider(),
            // ✅ الإشعارات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Notifications',
                      style: Styles.textStyleCom26,
                    ),
                  ],
                ),
                const AppSwitch()
              ],
            ),
            const SizedBox(height: 20),

            ProfileListTile(
              label: 'Change password',
              style: Styles.textStyleCom26,
              height: 45,
            ),
            const SizedBox(height: 20),

            ProfileListTile(
              label: 'Permissions',
              style: Styles.textStyleCom26,
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
