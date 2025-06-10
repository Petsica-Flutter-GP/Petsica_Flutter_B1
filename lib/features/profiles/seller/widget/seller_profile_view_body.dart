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

class SellerProfileViewBody extends StatelessWidget {
  const SellerProfileViewBody({super.key});

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
        body: SingleChildScrollView(
          // 📌 جعل الصفحة قابلة للتمرير
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 20), // إضافة هامش
          child: Column(
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
                "Mohammed Ahmed",
                style: Styles.textStyleCom26,
              ),
              Text(
                "Mohammed1@gmail.com | +01227606613",
                style: Styles.textStyleCom16,
              ),
              const SizedBox(height: 20),

              /// 🔹 الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'View Profile',
                      border: 15,
                      style: Styles.textStyleQui20.copyWith(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SizedBox(width: 10), // هامش بين الأزرار
                  Expanded(
                    child: AppButton(
                      text: 'Edit',
                      border: 15,
                      style: Styles.textStyleQui20.copyWith(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// 🔹 خط فاصل
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
