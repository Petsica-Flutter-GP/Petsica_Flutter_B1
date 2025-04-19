import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'storeproducts_state.dart';

class StoreproductsCubit extends Cubit<StoreproductsState> {
  StoreproductsCubit() : super(StoreproductsInitial());

  
}
