import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/features/profiles/user/cubit/profile_image_cubit.dart';
import 'package:petsica/features/profiles/widgets/profile_list_tile.dart';

import '../../../../core/constants.dart';
import '../../../../core/utils/app_button.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';
import '../../../signup/presentation/widgets/circle_image_picker.dart';

class ClinicProfileViewBody extends StatelessWidget {
  const ClinicProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileImageCubit(), // إنشاء `Cubit`
      child: Scaffold(
        backgroundColor: kWhiteGroundColor,
        appBar: AppBar(
          title: Text("Profile", style: Styles.textStyleQu28),
          centerTitle: true,
          leading: const AppArrowBack(destination: AppRouter.kWhereProfile),
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),

            /// 🔹 استخدام `BlocBuilder` للحصول على الصورة من `Cubit`
            BlocBuilder<ProfileImageCubit, File?>(
              builder: (context, profileImage) {
                return CircleProfileImagePicker(
                  image: profileImage, // الصورة المختارة
                  assetImage: AssetData.profileImage, // الصورة الافتراضية
                  name: 'user',
                  onImageSelected: (File? image) {
                    context.read<ProfileImageCubit>().emit(image);
                  },
                );
              },
            ),

            const SizedBox(height: 10),

            /// 🔹 معلومات المستخدم
            Text(
              "Puerto Rico",
              style: Styles.textStyleCom26,
            ),
            Text(
              "youremail@domain.com | +01 234 567 89",
              style: Styles.textStyleCom16,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButton(
                  text: 'View Profile',
                  border: 15,
                  width: 150,
                  style: Styles.textStyleQui20.copyWith(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
                AppButton(
                  text: 'Edit',
                  border: 15,
                  width: 150,
                  style: Styles.textStyleQui20.copyWith(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Divider(
                thickness: 1,
                height: 40,
                color: Colors.black,
              ),
            ),

            /// 🔹 القائمة الجانبية
            Column(
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
                      GoRouter.of(context).go(AppRouter.kClinicMyPet);
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
                const ProfileListTile(
                  iconasset: AssetData.logoutIcon,
                  label: 'Log out',
                  height: 37,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
