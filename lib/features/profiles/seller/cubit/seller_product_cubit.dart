import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/seller_product_state.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';

class SellerProductsCubit extends Cubit<SellerProductsState> {
  SellerProductsCubit() : super(SellerProductsInitial());

  Future<void> fetchProducts() async {
    emit(SellerProductsLoading());
    try {
      final products = await ProductService.getSellerProducts();
      emit(SellerProductsLoaded(products));
    } catch (e) {
      emit(SellerProductsError('Failed to load products: $e'));
    }
  }

  void deleteProduct(productId) {}
}
