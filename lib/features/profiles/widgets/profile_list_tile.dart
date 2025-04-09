import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/styles.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.iconasset,
    required this.label,
    required this.height,
    this.onTap,
  });

  final String iconasset;
  final String label;
  final double height;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        iconasset,
        height: height,
      ),
      title: Text(
        label,
        style: Styles.textStyleCom26,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap ?? () {},
    );
  }
}
