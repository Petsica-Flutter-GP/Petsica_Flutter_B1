// import 'package:bloc/bloc.dart';
// import 'package:petsica/features/profiles/logic/postAdoption/post_adoption_pet_toggle_state.dart';
// import 'package:petsica/features/profiles/services/pet_services.dart';

// class PetToggleCubit extends Cubit<PetToggleState> {
//   PetToggleCubit() : super(PetToggleInitial());

//   Future<void> togglePetAdoption(int petId) async {
//     try {
//       emit(PetToggleLoading()); // حالة التحميل
//       await PetServices.petAdoptionToggleOn(petId);
//       emit(PetToggleSuccess()); // حالة النجاح
//     } catch (e) {
//       emit(PetToggleFailure(e.toString())); // حالة الفشل
//     }
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:petsica/features/profiles/logic/postAdoption/post_adoption_pet_toggle_state.dart';
import 'package:petsica/features/profiles/services/pet_services.dart';


class PetToggleCubit extends Cubit<PetToggleState> {
  PetToggleCubit() : super(PetToggleInitial());

  Future<void> toggleAdoption(int petId) async {
    emit(PetToggleLoading());
    try {
      await PetServices.toggleAdoptionStatus(petId);
      emit(PetToggleSuccess(message: 'تم التبديل في التبني بنجاح'));
    } catch (e) {
      emit(PetToggleFailure(errorMessage: 'فشل التبديل في التبني: $e'));
    }
  }

  Future<void> toggleMating(int petId) async {
    emit(PetToggleLoading());
    try {
      await PetServices.toggleMatingStatus(petId);
      emit(PetToggleSuccess(message: 'تم التبديل في التزاوج بنجاح'));
    } catch (e) {
      emit(PetToggleFailure(errorMessage: 'فشل التبديل في التزاوج: $e'));
    }
  }
}