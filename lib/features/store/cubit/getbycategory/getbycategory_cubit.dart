// تعريف الـ Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/store/cubit/getbycategory/getbycategory_state.dart';
import 'package:petsica/features/store/services/store_services.dart';

class GetByCategoryCubit extends Cubit<GetByCategoryState> {
  GetByCategoryCubit() : super(GetByCategoryInitial());

  Future<void> getProductsByCategory(String category) async {
    try {
      emit(GetByCategoryLoading());
      final products = await StoreService.getByCategory(category);
      emit(GetByCategoryLoaded(products));
    } catch (e) {
      emit(GetByCategoryError('فشل في تحميل المنتجات من فئة $category: $e'));
    }
  }

  void reset() {
    emit(GetByCategoryInitial());
  }
}
