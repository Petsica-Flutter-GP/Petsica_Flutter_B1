import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_add_pets_state.dart';

class UserAddPetsCubit extends Cubit<UserAddPetsState> {
  UserAddPetsCubit() : super(UserAddPetsInitial());
}
