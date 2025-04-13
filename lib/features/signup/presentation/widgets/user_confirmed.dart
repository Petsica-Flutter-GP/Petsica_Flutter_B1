import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/styles.dart';

class UserConfirm extends StatelessWidget {
  const UserConfirm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kContainerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row (
            children: [
          Text(
            'Welcome to ',
            style: Styles.textStyleCom18.copyWith(
              color: kBurgColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Petsica',
            style: Styles.textStyleQui20.copyWith(
              color: kBurgColor,
            ),
          ),
          const Text(
            ' ! 🎉',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
            ]
          ),
          const SizedBox(height: 10),
          Text(
            "We're thrilled to have you join our community !\nKnow you can start your journey with us !",
            style: Styles.textStyleCom18.copyWith(
              color: kWordColor,
            ),
          ),
        ],
      ),
    );
  }
}
