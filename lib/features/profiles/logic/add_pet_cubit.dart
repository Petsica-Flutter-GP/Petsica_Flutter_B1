import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/model/pet_model.dart';
import 'package:petsica/features/profiles/services/add_pet_service.dart';
import 'add_pet_state.dart';

class AddPetCubit extends Cubit<AddPetState> {
  AddPetCubit() : super(AddPetInitial());

  Future<void> addPet(PetModel pet) async {
    emit(AddPetLoading());

    try {
      await PetService.addPet(
        name: pet.name,
        type: pet.breed,
        age: pet.species,
        gender: pet.gender,
        photoBase64: pet.photo,
      );
      emit(AddPetSuccess());
    } catch (e) {
      emit(AddPetFailure(e.toString()));
    }
  }
}
