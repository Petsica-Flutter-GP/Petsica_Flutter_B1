// import 'package:flutter/material.dart';
// import 'package:petsica/core/constants.dart';
// import 'package:petsica/core/utils/app_button.dart';
// import 'package:petsica/features/profiles/adminn/widget/admin_request_deletion_show_dialog.dart';
// import '../../../../core/utils/asset_data.dart';
// import '../../../../core/utils/styles.dart';

// class AdminSitterRequestsCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String location;
//   final double price;
//   final VoidCallback onDelete;

//   const AdminSitterRequestsCard({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.location,
//     required this.price,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       color: Colors.transparent,
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         children: [
//           ListTile(
//             contentPadding: const EdgeInsets.symmetric(horizontal: 0),
//             leading: CircleAvatar(
//               radius: 30,
//               backgroundColor: kBurgColor.withOpacity(0.1),
//               child: const Icon(
//                 Icons.person_outline,
//                 color: kBurgColor,
//                 size: 30,
//               ),
//             ),
//             title: Text(
//               title,
//               style: Styles.textStyleCom22.copyWith(
//                 color: kBurgColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 4),
//                 Text(
//                   location,
//                   style: Styles.textStyleCom16.copyWith(
//                     color: kProductTxtColor,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   description,
//                   style: Styles.textStyleCom14.copyWith(
//                     color: kBurgColor,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'Price: \$${price.toStringAsFixed(2)}',
//                   style: Styles.textStyleCom14.copyWith(
//                     color: kBurgColor,
//                   ),
//                 ),
//               ],
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 AppButton(
//                   text: 'Accept',
//                   style: Styles.textStyleCom14.copyWith(
//                     color: kWhiteGroundColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   border: 10,
//                   width: 75,
//                   onTap: () {
//                     print("Accepted request: $title");
//                   },
//                 ),
//                 const SizedBox(width: 15),
//                 IconButton(
//                   onPressed: () {
//                     _showDeleteDialog(context);
//                     print("Deleted request: $title");
//                   },
//                   icon: const Icon(
//                     Icons.close_outlined,
//                     color: kWordColor,
//                     size: 30,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 5),
//           const Divider(),
//           const SizedBox(height: 5),
//         ],
//       ),
//     );
//   }

//   void _showDeleteDialog(BuildContext context) {
//     AdminRequestDeletionShowDialog(context, onDelete);
//   }
// }
