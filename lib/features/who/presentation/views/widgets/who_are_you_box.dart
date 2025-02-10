import 'package:flutter/material.dart';
import 'package:petsica/core/utils/styles.dart';

class WhoAreYouBox extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;

  const WhoAreYouBox({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Image.asset(image, width: 131, height: 178),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: Styles.textStyleCom18,
        ),
      ],
    );
  }
}
