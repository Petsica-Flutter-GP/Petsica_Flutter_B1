import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/sitter/cubit/addService/add_service_state.dart';
import 'package:petsica/features/profiles/sitter/services/sitter_services.dart';

class AddSitterServiceCubit extends Cubit<AddSitterServiceState> {
  AddSitterServiceCubit() : super(AddSitterServiceInitial());

  Future<void> addService({
    required double price,
    required String description,
    required String title,
    required String location,
  }) async {
    emit(AddSitterServiceLoading());

    try {
      await SitterService.addSitterService(
        price: price,
        description: description,
        title: title,
        location: location,
      );
      emit(AddSitterServiceSuccess());
    } catch (e) {
      emit(AddSitterServiceFailure(e.toString()));
    }
  }
}
