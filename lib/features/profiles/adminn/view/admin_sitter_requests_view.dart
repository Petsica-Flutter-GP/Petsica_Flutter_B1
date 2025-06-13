import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetSitterService/admin_get_sitter_service_cubit.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_sitter_requests_view_body.dart';

class AdminSitterRequestsView extends StatelessWidget {
  const AdminSitterRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SitterApprovalCubit()..fetchSitterApprovals(),
      child: const AdminSitterRequestsViewBody(),
    );
  }
}
