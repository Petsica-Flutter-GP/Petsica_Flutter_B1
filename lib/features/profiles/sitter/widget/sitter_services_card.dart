import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';

import '../../../../core/utils/asset_data.dart';
import '../../../../core/utils/styles.dart';

class SitterCard extends StatelessWidget {
  const SitterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kStoreContainerColor,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: ClipOval(
          child: Image.asset(
            AssetData.profileImage,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text('User Name', style: Styles.textStyleCom24),
        subtitle: Text('\$10 per hour | pet type',
            style: Styles.textStyleCom16.copyWith(
              color: kProductTxtColor,
            )),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            GoRouter.of(context).go(
              AppRouter.kSitterEditServices,
            );
          },
        ),
      ),
    );
  }
}
