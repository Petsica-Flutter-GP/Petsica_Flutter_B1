import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/updateP/update_product_cubit.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/features/profiles/seller/cubit/updateP/update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit() : super(UpdateProductInitial());

  Future<void> updateProduct({
    required int productId,
    required String productName,
    required double price,
    required double discount,
    required String description,
    required int quantity,
    required String photo, // الصورة المُحدثة (إذا كانت موجودة)
    required ProductCategory category,
  }) async {
    try {
      emit(UpdateProductLoading());


      // بناء الطلب للتحديث
      final result = await ProductService.updateProduct(
        productId: productId,
        productName: productName,
        price: price,
        discount: discount,
        description: description,
        quantity: quantity,
        photo: photo,
        category: category,
      );

      if (result) {
        emit(UpdateProductSuccess());
      } else {
        emit(UpdateProductFailure( "Failed to update product."));
      }
    } catch (e) {
      emit(UpdateProductFailure( e.toString()));
    }
  }
}

