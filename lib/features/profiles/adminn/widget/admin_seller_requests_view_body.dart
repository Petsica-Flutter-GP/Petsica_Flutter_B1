import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetSellerService%20copy/admin_get_seller_service_cubit.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetSellerService%20copy/admin_get_seller_service_state.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_seller_requests_card.dart';

import '../../../../core/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSellerRequestsViewBody extends StatelessWidget {
  const AdminSellerRequestsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EAE6),
      appBar: AppBar(
        title: Text("Seller requests", style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kAdminProfile),
      ),
      body: BlocBuilder<SellerApprovalCubit, SellerApprovalState>(
        builder: (context, state) {
          if (state is SellerApprovalLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SellerApprovalFailure) {
            return Center(child: Text("❌ ${state.error}"));
          } else if (state is SellerApprovalSuccess) {
            final Sellers = state.SellerList;

            if (Sellers.isEmpty) {
              return const Center(child: Text("No requests yet"));
            }

            return ListView.builder(
              itemCount: Sellers.length,
              itemBuilder: (context, index) {
                final Seller = Sellers[index];
                return AdminRequestsCard(
                  sitter: Seller,
                  onAccept: () {
                    onAccept:
                    () {
                      context
                          .read<SellerApprovalCubit>()
                          .approveSeller(Seller.id);
                    };
                  },
                  onDelete: () {
                    // نفس الفكرة - حذف أو تجاهل الطلب
                  },
                );
              },
            );
          }

          return const SizedBox(); // Initial
        },
      ),
    );
  }
}
