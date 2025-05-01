// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:petsica/core/constants.dart';
// import 'package:petsica/core/utils/app_floating_button.dart';
// import 'package:petsica/features/profiles/widgets/pet_container.dart';
// import '../../../../core/utils/app_arrow_back.dart';
// import '../../../../core/utils/app_router.dart';
// import '../../../../core/utils/styles.dart';

// class SellerMyPetViewBody extends StatelessWidget {
//   const SellerMyPetViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kWhiteGroundColor,
//       appBar: AppBar(
//         title: Text("seller My pets", style: Styles.textStyleQu28),
//         centerTitle: true,
//         leading: const AppArrowBack(destination: AppRouter.kSellerProfile),
//       ),
//       floatingActionButton: AppFloatingButton(
//         color: kProducPriceColor,
//         icon: const Icon(
//           Icons.add,
//           size: 35,
//           color: kWhiteGroundColor,
//         ),
//         onPressed: () {
//           GoRouter.of(context).go(AppRouter.kSellerAddPet);
//         },
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         child: CustomScrollView(
//           slivers: [
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       GoRouter.of(context).go(
//                         AppRouter.kSellerPetDetails,
//                       );
//                     },
//                     child: const PetContainer(), // بدون بيانات إضافية
//                   );
//                 },
//                 childCount: 5, // عدد العناصر المعروضة
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
