import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/utils/asset_data.dart';

class Pet {
  final String image;
  final String name;

  Pet({required this.image, required this.name});

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      image: map['image'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
    };
  }
}

class AddPetCubit extends Cubit<List<Pet>> {
  AddPetCubit() : super([]);

  Future<void> fetchPets() async {
    emit([]);
    await Future.delayed(const Duration(seconds: 2));
    emit([
      Pet(image: AssetData.petImage, name: 'Bella'),
      Pet(image: AssetData.petImage, name: 'Charlie'),
    ]);
  }
}
