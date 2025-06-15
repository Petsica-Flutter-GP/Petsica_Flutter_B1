import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/logic/postAdoption/post_adoption_pet_toggle_cubit.dart';
import 'package:petsica/features/profiles/logic/postAdoption/post_adoption_pet_toggle_state.dart';
import 'package:petsica/features/profiles/model/get_pet_model.dart';

class PetContainer extends StatelessWidget {
  final GetPetModel pet;

  const PetContainer({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildPetImage(pet.photo),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🐾 اسم الحيوان
                  Text(
                    pet.name ?? 'Unknown Name',
                    style: Styles.textStyleCom22.copyWith(
                      color: kProductTxtColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ♂ نوع الحيوان
                  Row(
                    children: [
                      Icon(
                        pet.gender.toLowerCase() == 'male'
                            ? Icons.male
                            : Icons.female,
                        color: Colors.grey,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        pet.gender ?? 'Unknown',
                        style:
                            Styles.textStyleCom16.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // 🔄 أزرار التبديل
                  BlocConsumer<PetToggleCubit, PetToggleState>(
                    listener: (context, state) {
                      if (state is PetToggleSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      } else if (state is PetToggleFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is PetToggleLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<PetToggleCubit>()
                                    .toggleAdoption(pet.petID);
                              },
                              label: Text(
                                'Adoption',
                                style: Styles.textStyleCom14
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(163, 63, 121, 65),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<PetToggleCubit>()
                                    .toggleMating(pet.petID);
                              },
                              label: Text(
                                'Mating',
                                style: Styles.textStyleCom14
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(155, 194, 70, 111),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetImage(String? base64Image) {
    if (base64Image == null || base64Image.isEmpty) {
      return _defaultImage();
    }

    try {
      String fixedBase64 = base64Image.padRight(
        base64Image.length + ((4 - base64Image.length % 4) % 4),
        '=',
      );
      final bytes = base64Decode(fixedBase64);
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          bytes,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      );
    } catch (e) {
      return _defaultImage();
    }
  }

  Widget _defaultImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.pets,
        size: 36,
        color: Colors.white,
      ),
    );
  }
}