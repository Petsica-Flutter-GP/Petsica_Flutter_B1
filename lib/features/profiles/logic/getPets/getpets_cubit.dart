import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/logic/getPets/getpets_state.dart';
import 'package:petsica/features/profiles/services/pet_services.dart';

class PetCubit extends Cubit<PetState> {
  final PetServices petService;

  PetCubit({required this.petService}) : super(PetInitial());

  Future<void> fetchPets() async {
    try {
      emit(PetLoading());
      final pets = await PetServices.getAllPets();  // هنا برضه هنستخدم GetPetModel
      emit(PetLoaded(pets: pets));
    } catch (e) {
      emit(PetError(errorMessage: e.toString()));
    }
  }
}
