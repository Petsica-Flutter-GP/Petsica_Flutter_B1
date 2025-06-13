import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetClinicService%20copy/admin_get_clinic_service_cubit.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetClinicService%20copy/admin_get_clinic_service_state.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_seller_requests_card.dart';

class AdminClinicRequestsViewBody extends StatelessWidget {
  const AdminClinicRequestsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EAE6),
      appBar: AppBar(
        title: Text("Clinic requests", style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kAdminProfile),
      ),
      body: BlocBuilder<ClinicApprovalCubit, ClinicApprovalState>(
        builder: (context, state) {
          if (state is ClinicApprovalLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ClinicApprovalFailure) {
            return Center(child: Text("❌ ${state.error}"));
          } else if (state is ClinicApprovalSuccess) {
            final Clinics = state.ClinicList;

            if (Clinics.isEmpty) {
              return const Center(child: Text("No requests yet"));
            }

            return ListView.builder(
              itemCount: Clinics.length,
              itemBuilder: (context, index) {
                final Clinic = Clinics[index];
                return AdminRequestsCard(
                  sitter: Clinic,
                  onAccept: () {
                      context
                          .read<ClinicApprovalCubit>()
                          .approveClinic(Clinic.id);
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
