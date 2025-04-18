import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/features/profiles/user/cubit/add_pet_cubit.dart';
import 'package:petsica/features/profiles/widgets/pet_container.dart';
import '../../../../core/utils/app_arrow_back.dart';
import '../../../../core/utils/app_floating_button.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';

class ClinicMyPetViewBody extends StatelessWidget {
  const ClinicMyPetViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddPetCubit()..fetchPets(), // تشغيل `fetchPets` عند تحميل الصفحة
      child: Scaffold(
        backgroundColor: kWhiteGroundColor,
        appBar: AppBar(
          title: Text("clinic My pets", style: Styles.textStyleQu28),
          centerTitle: true,
          leading: const AppArrowBack(destination: AppRouter.kClinicProfile),
        ),
        floatingActionButton: AppFloatingButton(
          color: kProducPriceColor,
          icon: const Icon(
            Icons.add,
            size: 35,
            color: kWhiteGroundColor,
          ),
          onPressed: () {
            GoRouter.of(context).go(
              AppRouter.kClinicAddPet,
            );
          },
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
                            GoRouter.of(context).push(
                              AppRouter.kClinicPetDetails,
                              extra: pet.toMap(),
                            );
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
