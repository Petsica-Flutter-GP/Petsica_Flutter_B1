import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/model/get_pet_model.dart';
import 'package:petsica/features/profiles/services/pet_services.dart';

part 'pet_details_state.dart';

class PetDetailsCubit extends Cubit<PetDetailsState> {
  PetDetailsCubit() : super(PetDetailsInitial());

  Future<void> getPetDetails(int petId) async {
    emit(PetDetailsLoading());
    try {
      final pet = await PetServices.getPetDetails(petId);
      emit(PetDetailsLoaded(pet));
    } catch (e) {
      emit(PetDetailsError(e.toString()));
    }
  }
}
