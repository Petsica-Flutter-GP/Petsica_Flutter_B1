// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:petsica/core/utils/app_arrow_back.dart';
// import 'package:petsica/core/utils/app_router.dart';
// import 'package:petsica/core/utils/styles.dart';
// import 'package:petsica/core/constants.dart';
// import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetSitterService/admin_get_sitter_service_cubit.dart';
// import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetSitterService/admin_get_sitter_service_state.dart';
// import 'package:petsica/features/profiles/adminn/widget/admin_seller_requests_card.dart';
// import 'package:petsica/features/profiles/adminn/widget/admin_sitter_requests_card.dart';

// class AdminSitterRequestsViewBody extends StatefulWidget {
//   const AdminSitterRequestsViewBody({super.key});

//   @override
//   State<AdminSitterRequestsViewBody> createState() =>
//       _AdminSitterRequestsViewBodyState();
// }

// class _AdminSitterRequestsViewBodyState
//     extends State<AdminSitterRequestsViewBody> {
//   @override
//   void initState() {
//     super.initState();
//     // 🟢 استدعاء الداتا أول ما الصفحة تفتح
//     AdminSitterServicesCubit.get(context).adminfetchSitterServices();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kAppColor,
//       appBar: AppBar(
//         title: Text("Sitter requestss", style: Styles.textStyleQu28),
//         centerTitle: true,
//         leading: const AppArrowBack(destination: AppRouter.kAdminProfile),
//       ),
//       body: BlocBuilder<AdminSitterServicesCubit, AdminSitterServicesState>(
//         builder: (context, state) {
//           if (state is AdminSitterServicesLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is AdminSitterServicesLoaded) {
//             final services = state.services;

//             if (services.isEmpty) {
//               return const Center(child: Text("No requsest for now.."));
//             }

//             return ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//               itemCount: services.length,
//               itemBuilder: (context, index) {
//                 final service = services[index];
//                 return GestureDetector(
//                   onTap: () {
//                     GoRouter.of(context).go(AppRouter.kAdminRequestDetails);
//                   },
//                   child: AdminSitterRequestsCard(
//                     title: service.title,
//                     description: service.description,
//                     location: service.location,
//                     price: service.price,
//                     onDelete: () {
//                       print("Deleted service with ID: ${service.serviceID}");
//                     },
//                   ),
//                 );
//               },
//             );
//           } else if (state is AdminSitterServicesError) {
//             return Center(child: Text("Error: ${state.message}"));
//           } else {
//             return const SizedBox();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetSitterService/admin_get_sitter_service_cubit.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/AdminGetSitterService/admin_get_sitter_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_seller_requests_card.dart';

class AdminSitterRequestsViewBody extends StatelessWidget {
  const AdminSitterRequestsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EAE6),
      appBar: AppBar(
        title: Text("Sitter requests", style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kAdminProfile),
      ),
      body: BlocBuilder<SitterApprovalCubit, SitterApprovalState>(
        builder: (context, state) {
          if (state is SitterApprovalLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SitterApprovalFailure) {
            return Center(child: Text("❌ ${state.error}"));
          } else if (state is SitterApprovalSuccess) {
            final sitters = state.sitterList;

            if (sitters.isEmpty) {
              return const Center(child: Text("No requests yet"));
            }

            return ListView.builder(
              itemCount: sitters.length,
              itemBuilder: (context, index) {
                final sitter = sitters[index];
                return AdminRequestsCard(
                  sitter: sitter,
                  onAccept: () {
                    onAccept:
                    () {
                      context
                          .read<SitterApprovalCubit>()
                          .approveSitter(sitter.id);
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
