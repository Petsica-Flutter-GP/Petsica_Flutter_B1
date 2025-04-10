import 'package:flutter/material.dart';
import 'package:petsica/features/profiles/clinic/widget/clinic_pet_details_view_body.dart';
import 'package:petsica/features/profiles/user/cubit/add_pet_cubit.dart';
import 'package:petsica/features/profiles/user/widgets/user_pet_details_view_body.dart';

class ClinicPetDetailsView extends StatelessWidget {

  const ClinicPetDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicPetDetailsViewBody();
  }
}
