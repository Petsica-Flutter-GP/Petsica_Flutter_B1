// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:petsica/features/profiles/adminn/cubit/completeorderbyadmin/completeorderbyadmin_state.dart';
// import 'package:petsica/features/profiles/adminn/services/admin_services.dart';

// class CompleteOrderCubit extends Cubit<CompleteOrderState> {
//   CompleteOrderCubit() : super(CompleteOrderInitial());

//   Future<void> completeOrder(int orderId) async {
//     emit(CompleteOrderLoading());

//     try {
//       await AdminServices.completeOrder(orderId);
//       emit(CompleteOrderSuccess());
//     } catch (e) {
//       emit(CompleteOrderErrorState(handleErrorMessage(e.toString())));
//     }
//   }

//   // String handleErrorMessage(dynamic error) {
//   //   try {
//   //     final decoded = jsonDecode(error);
//   //     if (decoded is Map && decoded.containsKey('description')) {
//   //       return decoded['description'];
//   //     } else {
//   //       return "Unexpected error , try again later";
//   //     }
//   //   } catch (e) {
//   //     return "Failed , please try again";
//   //   }
//   // }

// String handleErrorMessage(dynamic error) {
//   if (error is String) {
//     return error.replaceAll('Exception:', '').trim();
//   } else {
//     return "Failed , try again later..";
//   }
// }


// }
