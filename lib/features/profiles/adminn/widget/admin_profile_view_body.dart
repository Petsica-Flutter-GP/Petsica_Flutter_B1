import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_profile_menu.dart';
import 'package:petsica/features/profiles/logic/viewProfile/profile_cubit.dart';
import 'package:petsica/features/profiles/user/cubit/profile_image_cubit.dart';
import 'package:petsica/features/profiles/widgets/profile_list_tile.dart';

import '../../../../core/constants.dart';
import '../../../../core/utils/app_button.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';
import '../../../signup/presentation/widgets/circle_image_picker.dart';

class AdminProfileViewBody extends StatelessWidget {
  const AdminProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit()..getProfile(), // 👉 تحميل البيانات هنا
      child: Scaffold(
        backgroundColor: kWhiteGroundColor,
        appBar: AppBar(
          title: Text("Profile", style: Styles.textStyleQu28),
          centerTitle: true,
          leading: const AppArrowBack(destination: AppRouter.kWhereProfile),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileFailure) {
              return Center(child: Text('❌ ${state.error}'));
            } else if (state is ProfileSuccess) {
              final profile = state.profile;

              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    CircleProfileImagePicker(
                      image: null,
                      assetImage: AssetData.profileImage,
                      name: profile.userName,
                      onImageSelected: (File? image) {},
                    ),
                    const SizedBox(height: 10),

                    /// 🔹 معلومات المستخدم
                    Text(
                      profile.userName ?? 'No name',
                      style: Styles.textStyleCom26,
                    ),
                    Text(
                      profile.email,
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
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AppButton(
                            text: 'Edit',
                            onTap: () {
                              GoRouter.of(context).go(
                                AppRouter.kEditProfile,
                              );
                            },
                            border: 15,
                            style: Styles.textStyleQui20.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Divider(
                        thickness: 1,
                        height: 40,
                        color: Colors.black,
                      ),
                    ),

                    /// 🔹 القائمة الجانبية
                    const AdminProfileMenu(),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
