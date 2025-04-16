// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:petsica/features/profiles/seller/cubit/git/get_my_products_cubit.dart';
// import 'package:petsica/features/profiles/seller/cubit/git/get_my_products_state.dart';
// import 'package:petsica/features/profiles/seller/services/product_services.dart';

// class GetMyProductsCubit extends Cubit<MyProductsState> {
//   GetMyProductsCubit() : super(MyProductsInitial());

//   Future<void> fetchProducts() async {
//     emit(MyProductsLoading()); // تفعيل حالة التحميل

//     try {
//       final products = await ProductService.getSellerProducts(); // استخدام ProductService بدلاً من http.get
//       emit(MyProductsLoaded(products)); // تفعيل حالة النجاح
//     } catch (e) {
//       emit(MyProductsError('Error: $e')); // في حالة حدوث خطأ
//     }
//   }
// }
