// import 'package:bloc/bloc.dart';

// class CartCubit extends Cubit<List<Map<String, dynamic>>> {
//   CartCubit() : super([]);

//   double getTotalPrice() {
//     return state.fold(0, (total, item) => total + (item['price'] * item['quantity']));
//   }

//   int getTotalItems() {
//     return state.fold<int>(0, (sum, item) => sum + (item['quantity'] as int));
//   }

//   void addItem(Map<String, dynamic> item) {
//     emit([...state, item]);
//   }

//   void removeItem(int index) {
//     final newState = List<Map<String, dynamic>>.from(state);
//     newState.removeAt(index);
//     emit(newState);
//   }

//   void updateItemQuantity(int index, int newQuantity) {
//     final newState = List<Map<String, dynamic>>.from(state);
//     newState[index]['quantity'] = newQuantity;
//     emit(newState);
//   }
// }
