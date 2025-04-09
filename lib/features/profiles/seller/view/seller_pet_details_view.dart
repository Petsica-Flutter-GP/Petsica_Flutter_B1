import 'package:flutter/material.dart';
import 'package:petsica/features/profiles/seller/widget/seller_pet_details_view_body.dart';
import 'package:petsica/features/profiles/user/cubit/add_pet_cubit.dart';
import 'package:petsica/features/profiles/user/widgets/user_pet_details_view_body.dart';

class SellerPetDetailsView extends StatelessWidget {
  final Pet pet;

  const SellerPetDetailsView({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return SellerPetDetailsViewBody(pet: pet);
  }
}
