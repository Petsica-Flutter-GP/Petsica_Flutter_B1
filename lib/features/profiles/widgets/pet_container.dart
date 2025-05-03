import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/features/profiles/model/get_pet_model.dart';
import '../../../core/utils/styles.dart';

class PetContainer extends StatelessWidget {
  final GetPetModel pet;

  const PetContainer({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go(
          AppRouter.kPetDetails,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kAddPetContainerColor.withOpacity(0.8),
              Colors.white.withOpacity(0.5)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: pet.photo.isNotEmpty
                  ? Image.memory(
                      base64Decode(pet.photo),
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    )
                  : const Image(
                      width: 70,
                      height: 70,
                      image: AssetImage(AssetData.clinicImage),
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: Styles.textStyleCom22.copyWith(
                        color: kProductTxtColor, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
