import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetSellerService%20copy/admin_get_seller_service_cubit.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_Seller_requests_view_body.dart';

class AdminSellerRequestsView extends StatelessWidget {
  const AdminSellerRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SellerApprovalCubit()..fetchSellerApprovals(),
      child: const AdminSellerRequestsViewBody(),
    );
  }
}
