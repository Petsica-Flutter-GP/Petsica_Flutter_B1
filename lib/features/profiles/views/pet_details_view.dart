import 'package:flutter/material.dart';
import 'package:petsica/features/profiles/model/get_pet_model.dart';
import 'package:petsica/features/profiles/widgets/pet_details_view_body.dart';

class PetDetailsView extends StatelessWidget {
  const PetDetailsView({super.key, required this.pet});

  final GetPetModel pet;

  @override
  Widget build(BuildContext context) {
    return PetDetailsViewBody(pet: pet);
  }
}
