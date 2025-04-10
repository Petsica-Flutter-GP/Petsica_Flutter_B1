import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';

class AppFloatingButton extends StatelessWidget {
  final Color color;
  final Icon icon;

  const AppFloatingButton({
    super.key,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableFab(
      child: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: color,
          shape: const CircleBorder(),
          onPressed: () {
            GoRouter.of(context).go(AppRouter.kWhoEdit);
          },
          child: icon,
        ),
      ),
    );
  }
}
