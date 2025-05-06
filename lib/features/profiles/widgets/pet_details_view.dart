import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/features/profiles/model/get_pet_model.dart';
import 'package:petsica/features/profiles/widgets/pet_details_view_body.dart';

class PetDetailsView extends StatelessWidget {
  const PetDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final pet = GoRouterState.of(context).extra as GetPetModel;

    return PetDetailsViewBody(pet: pet);
  }
}
