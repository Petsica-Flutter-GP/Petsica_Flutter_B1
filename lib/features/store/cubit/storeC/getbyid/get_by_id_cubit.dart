import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/storeC/getbyid/get_by_id_state.dart';
import 'package:petsica/features/store/services/store_services.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsLoading());

  void fetchProductDetails(int productId) async {
    try {
      emit(ProductDetailsLoading());
      final product = await StoreService.getProductByID(productId);
      emit(ProductDetailsSuccess(product));
    } catch (e) {
      emit(ProductDetailsFailure(e.toString()));
    }
  }
}
