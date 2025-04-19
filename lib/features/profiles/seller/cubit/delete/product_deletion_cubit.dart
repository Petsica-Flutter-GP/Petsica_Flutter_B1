import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';

part 'product_deletion_state.dart';

class ProductDeletionCubit extends Cubit<ProductDeletionState> {
  ProductDeletionCubit() : super(ProductDeletionInitial());

  // دالة لحذف المنتج
  Future<void> deleteProduct(int productId) async {
    emit(ProductDeletionLoading()); // حالة التحميل

    try {
      // محاولة حذف المنتج
      final result = await ProductService.deleteProduct(productId);
      if (result) {
        emit(ProductDeletionSuccess()); // حالة النجاح
      } else {
        emit(ProductDeletionFailure(message: "Failed to delete product"));
      }
    } catch (e) {
      emit(ProductDeletionFailure(message: e.toString())); // حالة الفشل
    }
  }
}
