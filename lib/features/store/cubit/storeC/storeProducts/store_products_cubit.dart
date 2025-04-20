import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'store_products_state.dart';

class StoreproductsCubit extends Cubit<StoreproductsState> {
  StoreproductsCubit() : super(StoreproductsInitial());

  
}
