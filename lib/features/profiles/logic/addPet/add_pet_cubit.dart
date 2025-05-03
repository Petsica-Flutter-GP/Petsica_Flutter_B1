import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/model/post_pet_model.dart';
import 'package:petsica/features/profiles/services/pet_services.dart';
import 'add_pet_state.dart';

class AddPetCubit extends Cubit<AddPetState> {
  AddPetCubit() : super(AddPetInitial());

  Future<void> addPet(PetModel pet) async {
    emit(AddPetLoading());

    try {
      await PetServices.addPet(
        name: pet.name,
        type: pet.type,
        age: pet.age,
        gender: pet.gender,
        photoBase64: pet.photo,
      );
      emit(AddPetSuccess());
    } catch (e) {
      emit(AddPetFailure(e.toString()));
    }
  }
}
