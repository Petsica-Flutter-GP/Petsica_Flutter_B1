
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';

part 'product_deletion_state.dart';

class ProductDeletionCubit extends Cubit<ProductDeletionState> {
  ProductDeletionCubit() : super(ProductDeletionInitial());

  Future<void> deleteProduct(int productId) async {
    emit(ProductDeletionLoading());
    try {
      final success = await ProductService.deleteProduct(productId);
      if (success) {
        emit(ProductDeletionSuccess());
      } else {
        emit(ProductDeletionFailure("Delete failed"));
      }
    } catch (e) {
      emit(ProductDeletionFailure("Error: $e"));
    }
  }
}
