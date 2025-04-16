import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/add/add_product_cubit_state.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/helpers/http_helper.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  Future<void> addProduct({
    required String name,
    required double price,
    required String description,
    required ProductCategory category,
    required String photo,
    double discount = 0.0,
    int quantity = 1,
  }) async {
    emit(AddProductLoading());

    try {
      final success = await ProductService.addProduct(
        productName: name,
        price: price,
        discount: discount,
        description: description,
        quantity: quantity,
        photo: photo ,
        category: category,
      );

      if (success) {
        emit(AddProductSuccess()
);
        print('📸 base64 photo: $photo');
      } else {
        emit(AddProductError("❌ Failed to add product"));
      }
    } catch (e) {
      print("❌ Error while adding product: $e");
      emit(AddProductError("Error: $e"));
    }
  }
}
