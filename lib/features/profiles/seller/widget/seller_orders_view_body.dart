import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/getOrders/seller_orders_cubit.dart';
import 'package:petsica/features/profiles/seller/cubit/getOrders/seller_orders_state.dart';
import 'package:petsica/features/profiles/seller/widget/seller_orders_card.dart';
import '../../../../core/constants.dart';
import '../../../../core/utils/app_arrow_back.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';

class SellerOrdersViewBody extends StatelessWidget {
  const SellerOrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppColor,
      appBar: AppBar(
        title: Text("My orders", style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kSellerProfile),
      ),
      body: BlocProvider(
        create: (context) => SellerOrdersCubit()..fetchSellerOrders(),
        child: BlocBuilder<SellerOrdersCubit, SellerOrdersState>(
          builder: (context, state) {
            if (state is SellerOrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SellerOrdersSuccess) {
              if (state.orders.isEmpty) {
                return const Center(child: Text('No orders found.'));
              }
              return
                  // ListView.builder(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  //   itemCount: state.orders.length,
                  //   itemBuilder: (context, index) {
                  //     return SellerOrdersCard(order: state.orders[index]);
                  //   },
                  // );
                  ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  return SellerOrdersCard(
                    order: state.orders[index],
                    index: index, 
                  );
                },
              );
            } else if (state is SellerOrdersFailure) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
