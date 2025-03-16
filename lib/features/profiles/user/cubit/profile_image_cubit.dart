import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageCubit extends Cubit<File?> {
  ProfileImageCubit() : super(null); // الصورة تبدأ بـ null

  /// 📌 اختيار صورة من المعرض أو الكاميرا
  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        emit(File(image.path)); // تحديث الصورة الجديدة
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  /// 📌 حذف الصورة
  void deleteImage() {
    emit(null);
  }
}
