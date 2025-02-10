import 'package:flutter/material.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/utils/styles.dart';

class LogSign extends StatelessWidget {
  const LogSign({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: Styles.textStyleCom14,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              text2,
              style: Styles.textStyleCom14.copyWith(
                fontWeight: FontWeight.w600,
                color: kWordColor,
                decoration: TextDecoration.underline, // ✅ خط تحت النص
              ),
            ),
          ),
        ],
      ),
    );
  }
}
