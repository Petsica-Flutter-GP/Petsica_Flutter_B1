import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_button.dart';
import '../../../../core/utils/asset_data.dart';
import '../../../../core/utils/styles.dart';

class SellerOrdersCard extends StatelessWidget {
  const SellerOrdersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: ClipOval(
              child: Image.asset(
                AssetData.profileImage,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text('User Name',
                style: Styles.textStyleCom22
                    .copyWith(color: kBurgColor, fontWeight: FontWeight.bold)),
            subtitle: Text('Fayoum',
                style: Styles.textStyleCom16.copyWith(
                  color: kProductTxtColor,
                )),
            trailing: AppButton(
              text: 'Accept',
              style: Styles.textStyleCom14.copyWith(
                  color: kWhiteGroundColor, fontWeight: FontWeight.bold),
              border: 10,
              width: 75,
              onTap: () {
                // GoRouter.of(context).go(
                //   AppRouter.kSellerOrderDetails,
                // );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
