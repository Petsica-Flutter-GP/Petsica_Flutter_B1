import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/utils/asset_data.dart';

class Pet {
  final String image;
  final String name;

  Pet({required this.image, required this.name});
}

/// 🔹 Cubit لإدارة حالة قائمة الحيوانات
class AddPetCubit extends Cubit<List<Pet>> {
  AddPetCubit() : super([]);

  /// 🔹 محاكاة جلب البيانات من API
  Future<void> fetchPets() async {
    emit([]); // تهيئة القائمة فارغة أولًا
    await Future.delayed(const Duration(seconds: 2)); // محاكاة التأخير

    List<Pet> pets = [
      Pet(image: AssetData.petImage, name: 'Bella'),
      Pet(image: AssetData.petImage, name: 'Charlie'),
      Pet(image: AssetData.petImage, name: 'Max'),
      Pet(image: AssetData.petImage, name: 'Max'),
      Pet(image: AssetData.petImage, name: 'Max'),
      Pet(image: AssetData.petImage, name: 'Max'),
    
    ];

    emit(pets); // تحديث الحالة بالبيانات
  }
}
