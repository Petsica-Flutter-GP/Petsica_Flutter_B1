import 'package:flutter/material.dart';
import 'package:petsica/features/who/presentation/views/widgets/who_body.dart';


class Who extends StatelessWidget {
  const Who({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WhoBody(),
    );
  }
}
