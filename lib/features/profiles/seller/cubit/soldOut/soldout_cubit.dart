import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/soldOut/soldout_state.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';

class SoldOutCubit extends Cubit<SoldOutState> {
  SoldOutCubit() : super(SoldOutInitial());

  Future<void> markProductAsSoldOut(int productId) async {
    try {
      emit(SoldOutLoading());
      
      // التفاعل مع API لتحديث المنتج
      bool success = await ProductService.markProductAsSoldOut(productId);
      
      if (success) {
        emit(SoldOutSuccess(productId: productId));
      } else {
        emit(SoldOutError(message: 'Failed to mark product as sold out.'));
      }
    } catch (e) {
      emit(SoldOutError(message: e.toString()));
    }
  }
}
