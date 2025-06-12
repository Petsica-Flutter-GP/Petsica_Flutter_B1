import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/sitter/cubit/getService/get_my_service_state.dart';
import 'package:petsica/features/profiles/sitter/services/sitter_sercies.dart';


class SitterServicesCubit extends Cubit<SitterServicesState> {
  SitterServicesCubit() : super(SitterServicesInitial());

  static SitterServicesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchSitterServices() async {
    emit(SitterServicesLoading());

    try {
      final services = await SitterService.getMyServices();
      emit(SitterServicesLoaded(services));
    } catch (e) {
      emit(SitterServicesError(e.toString()));
    }
  }
}
