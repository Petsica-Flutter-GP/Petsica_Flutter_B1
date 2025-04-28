
import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';

import '../../../core/utils/styles.dart';

class PetContainer extends StatelessWidget {
  const PetContainer({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kAddPetContainerColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
        const  CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(AssetData.clinicImage),
          ),
          const SizedBox(width: 12),
          Text(
            'pet.name',
            style: Styles.textStyleCom22
                .copyWith(color: kProductTxtColor),
          ),
        ],
      ),
    );
  }
}
