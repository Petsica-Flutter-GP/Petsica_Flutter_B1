
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_floating_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/sitter/cubit/getService/get_my_service_cubit.dart';
import 'package:petsica/features/profiles/sitter/cubit/getService/get_my_service_state.dart';
import 'package:petsica/features/profiles/sitter/widget/sitter_card.dart';

class SitterMyServicesViewBody extends StatelessWidget {
  const SitterMyServicesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteGroundColor,
      appBar: AppBar(
        title: Text("My Services", style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kSitterProfile),
      ),
      floatingActionButton: AppFloatingButton(
        color: kProducPriceColor,
        icon: const Icon(Icons.add, size: 35, color: kWhiteGroundColor),
        onPressed: () {
          GoRouter.of(context).go(AppRouter.kSitterNewServices);
        },
      ),
      body: BlocProvider(
        create: (_) => SitterServicesCubit()..fetchSitterServices(),
        child: BlocBuilder<SitterServicesCubit, SitterServicesState>(
          builder: (context, state) {
            if (state is SitterServicesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SitterServicesLoaded) {
              final services = state.services;

              if (services.isEmpty) {
                return const Center(child: Text("No services yet"));
              }

          return ListView.builder(
  padding: const EdgeInsets.all(16),
  itemCount: services.length,
  itemBuilder: (context, index) {
    return SitterCard(service: services[index]);
  },
);


            } else if (state is SitterServicesError) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
