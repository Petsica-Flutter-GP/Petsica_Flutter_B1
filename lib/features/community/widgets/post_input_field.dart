import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';

class PostInputField extends StatelessWidget {
  const PostInputField({
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
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(AssetData.profileIcon),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'Pero Osama',
                style: Styles.textStyleQui20.copyWith(
                  color: kBurgColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const TextField(
            decoration: InputDecoration(
              hintText: "Write Here...",
              border: InputBorder.none,
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
