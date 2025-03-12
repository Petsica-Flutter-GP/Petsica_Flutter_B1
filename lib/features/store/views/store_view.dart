import 'package:flutter/material.dart';
import 'package:petsica/features/store/widgets/store_view_body.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreViewBody(),
    );
  }
}
