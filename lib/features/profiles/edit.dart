// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:petsica/core/utils/app_button.dart';
// import 'package:petsica/core/utils/app_router.dart';

// class WhereEdit extends StatelessWidget {
//   const WhereEdit({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AppButton(
//           text: 'user',
//           border: 20,
//           onTap: () {
//             GoRouter.of(context).go(AppRouter.kUserEditPet);
//           },
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//         AppButton(
//           text: 'seller',
//           border: 20,
//           onTap: () {
//             GoRouter.of(context).go(AppRouter.kSellerEditPet);
//           },
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//         AppButton(
//           text: 'sitter',
//           border: 20,
//           onTap: () {
//             GoRouter.of(context).go(AppRouter.kSitterEditPet);
//           },
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//         AppButton(
//           text: 'clinic',
//           border: 20,
//           onTap: () {
//             GoRouter.of(context).go(AppRouter.kClinicEditPet);
//           },
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//       ],
//     );
//   }
// }
