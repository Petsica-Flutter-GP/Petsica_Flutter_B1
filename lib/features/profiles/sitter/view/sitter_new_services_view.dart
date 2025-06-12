import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/sitter/cubit/addService/add_service_cubit.dart';
import 'package:petsica/features/profiles/sitter/widget/sitter_new_services_view.dart';

class SitterNewServicesView extends StatelessWidget {
  const SitterNewServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddSitterServiceCubit(),
      child: const SitterNewServicesViewBody(),
    );
  }
}
