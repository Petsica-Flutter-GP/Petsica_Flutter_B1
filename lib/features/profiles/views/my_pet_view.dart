import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/logic/postAdoption/post_adoption_pet_toggle_cubit.dart';
import 'package:petsica/features/profiles/widgets/my_pet_view_body.dart';

class MyPetView extends StatelessWidget {
  const MyPetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PetToggleCubit(),
      child: const MyPetViewBody(),
    );
  }
}