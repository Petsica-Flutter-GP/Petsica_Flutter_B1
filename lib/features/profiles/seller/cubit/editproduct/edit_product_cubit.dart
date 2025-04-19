import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/utils/send_Authorized_Request.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit() : super(EditProductInitial());

  Future<void> editProduct({
    required int productId,
    required String productName,
    required double price,
    required double discount,
    required String description,
    required int quantity,
    required String photo,
    required ProductCategory category,
    required String sellerId, // ✅ جديد
    required bool isAvailable, // ✅ جديد
  }) async {
    emit(EditProductLoading());

    try {
      final url =
          Uri.parse('http://petsica.runasp.net/api/Products/edit/$productId');

      // إعداد الـ body
      final requestBody = json.encode({
        'productId': productId,
        'price': price,
        'discount': discount,
        'productName': productName,
        'description': description,
        'quantity': quantity,
        'photo': photo,
        'category': category.name, // تأكد من إرسال الفئة بشكل صحيح
        'sellerId': sellerId, // إرسال الـ sellerId
        'isAvailable': isAvailable, // إرسال الـ isAvailable
      });

      // طباعة الـ body في terminal
      log('Request body: $requestBody');

      final response = await sendAuthorizedRequest(
        url: url,
        method: 'PUT',
        body: requestBody,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 204 ||
          response.statusCode == 201) {
        emit(EditProductSuccess());
      } else {
        emit(EditProductFailure("فشل التعديل. تأكد من البيانات."));
        log('@@@@@@@Error: ${response.body}');
      }
    } catch (e) {
      emit(EditProductFailure("خطأ أثناء التعديل: $e"));
      log('@@@@@@@Exception: $e');
    }
  }
}
