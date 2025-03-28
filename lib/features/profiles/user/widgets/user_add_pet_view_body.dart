import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/features/profiles/user/cubit/add_pet_cubit.dart';
import 'package:petsica/features/profiles/user/widgets/pet_container.dart';

import '../../../../core/utils/app_arrow_back.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';

class UserAddPetViewBody extends StatelessWidget {
  const UserAddPetViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddPetCubit()..fetchPets(), // تشغيل `fetchPets` عند تحميل الصفحة
      child: Scaffold(
        backgroundColor: kWhiteGroundColor,
        appBar: AppBar(
          title: Text("My pets", style: Styles.textStyleQu28),
          centerTitle: true,
          leading: const AppArrowBack(destination: AppRouter.kUserProfile),
        ),
        body: BlocBuilder<AddPetCubit, List<Pet>>(
          builder: (context, pets) {
            if (pets.isEmpty) {
              return const Center(
                  child: CircularProgressIndicator(
                color: kBurgColor,
                strokeWidth: 5,
              ));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final pet = pets[index];
                        return GestureDetector(
                          onTap: () {
                          },
                          child: PetContainer(pet: pet),
                        );
                      },
                      childCount: pets.length,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
