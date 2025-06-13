import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetClinicService%20copy/admin_get_clinic_service_cubit.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_Clinic_requests_view_body.dart';

class AdminClinicRequestsView extends StatelessWidget {
  const AdminClinicRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClinicApprovalCubit()..fetchClinicApprovals(),
      child: const AdminClinicRequestsViewBody(),
    );
  }
}
