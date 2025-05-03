// my_pet_view_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_floating_button.dart';
import 'package:petsica/features/profiles/logic/getPets/getpets_cubit.dart';
import 'package:petsica/features/profiles/logic/getPets/getpets_state.dart';
import 'package:petsica/features/profiles/services/pet_services.dart';
import 'package:petsica/features/profiles/widgets/pet_container.dart';
import 'package:petsica/features/profiles/widgets/pet_shimmer_container.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/utils/app_arrow_back.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/styles.dart';

class MyPetViewBody extends StatelessWidget {
  const MyPetViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteGroundColor,
      floatingActionButton: AppFloatingButton(
        color: kProducPriceColor,
        icon: const Icon(
          Icons.add,
          size: 35,
          color: kWhiteGroundColor,
        ),
        onPressed: () {
          GoRouter.of(context).go(AppRouter.kAddPet);
        },
      ),
      body: BlocProvider(
        create: (context) => PetCubit(petService: PetServices())..fetchPets(),
        child: BlocBuilder<PetCubit, PetState>(
          builder: (context, state) {
            if (state is PetLoading) {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 80),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const PetShimmerContainer(),
                      childCount: 5,
                    ),
                  ),
                ],
              );
            } else if (state is PetLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    backgroundColor: kWhiteGroundColor,
                    elevation: 0,
                    leading:
                        const AppArrowBack(destination: AppRouter.kUserProfile),
                    centerTitle: true,
                    title: Text("My pets", style: Styles.textStyleQu28),
                  ),
                  if (state.pets.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'No pets found!',
                              style: Styles.textStyleCom22
                                  .copyWith(color: kProductTxtColor),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Start by adding your lovely pet 🐾',
                              style: Styles.textStyleCom22
                                  .copyWith(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final pet = state.pets[index];
                            return GestureDetector(
                              onTap: () {
                                GoRouter.of(context).go(AppRouter.kPetDetails);
                              },
                              child: PetContainer(pet: pet),
                            );
                          },
                          childCount: state.pets.length,
                        ),
                      ),
                    ),
                ],
              );
            } else if (state is PetError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
