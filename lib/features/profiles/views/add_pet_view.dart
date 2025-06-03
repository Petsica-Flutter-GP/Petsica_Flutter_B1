import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/logic/addPet/add_pet_cubit.dart';
import 'package:petsica/features/profiles/widgets/add_pet_view_body.dart';

class AddPetView extends StatelessWidget {
  const AddPetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddPetCubit(),
      child: const AddPetPageViewBody(),
    );
  }
}
