import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/styles.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    Key? key,
    this.iconasset,
    required this.label,
    this.style,
    this.height = 24,
    this.onTap,
  }) : super(key: key);

  final String? iconasset;
  final String label;
  final TextStyle? style;
  final double height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconasset != null
          ? SvgPicture.asset(
              iconasset!,
              height: height,
            )
          : null,
      title: Text(
        label,
        style: style ?? Styles.textStyleCom26,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap ?? () {},
    );
  }
}
