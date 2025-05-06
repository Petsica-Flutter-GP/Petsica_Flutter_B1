import 'package:bloc/bloc.dart';
import 'package:petsica/features/profiles/logic/postAdoption/post_adoption_pet_toggle_state.dart';
import 'package:petsica/features/profiles/services/pet_services.dart';

class PetToggleCubit extends Cubit<PetToggleState> {
  PetToggleCubit() : super(PetToggleInitial());

  Future<void> togglePetAdoption(int petId) async {
    try {
      emit(PetToggleLoading()); // حالة التحميل
      await PetServices.petAdoptionToggleOn(petId);
      emit(PetToggleSuccess()); // حالة النجاح
    } catch (e) {
      emit(PetToggleFailure(e.toString())); // حالة الفشل
    }
  }
}
