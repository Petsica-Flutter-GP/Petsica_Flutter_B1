import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/profiles/adminn/cubit/getallordersbyadmin/getallordersbyadmin_state.dart';


class AdminOrdersCubit extends Cubit<AdminOrdersState> {
  AdminOrdersCubit() : super(AdminOrdersInitial());

  Future<void> fetchAllOrders() async {
    emit(AdminOrdersLoading());

    try {
      final url = Uri.parse('http://petsica.runasp.net/api/Orders/all');

      final response = await sendAuthorizedRequest(
        url: url,
        method: 'GET',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        emit(AdminOrdersLoaded(orders: data));
      } else {
        emit(AdminOrdersError(message: 'Failed with status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(AdminOrdersError(message: 'Exception: $e'));
    }
  }
}
