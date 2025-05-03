// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';

import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/widgets/app_switch.dart';

class AdoptionOrMatongToggle extends StatelessWidget {
  final String text;
  const AdoptionOrMatongToggle({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: kInputFieldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kProducPriceColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Styles.textStyleCom18
                .copyWith(color: const Color.fromARGB(255, 66, 70, 65)),
          ),
          const AppSwitch(),
        ],
      ),
    );
  }
}
