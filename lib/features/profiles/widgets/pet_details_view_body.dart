import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/model/get_pet_model.dart';
import 'package:petsica/features/profiles/widgets/app_switch.dart';
import 'dart:convert';

class PetDetailsViewBody extends StatelessWidget {
  const PetDetailsViewBody({super.key, required this.pet});
  final GetPetModel pet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteGroundColor,
      appBar: AppBar(
        title: Text(pet.name, style: Styles.textStyleQu28),
        centerTitle: true,
        leading: const AppArrowBack(destination: AppRouter.kMyPet),
      ),
      body: SingleChildScrollView(
        // إضافة التمرير
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عرض الصورة
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: pet.photo.isNotEmpty
                  ? Image.memory(
                      base64Decode(pet.photo), // تحويل base64 إلى صورة
                      fit: BoxFit.cover,
                      height: 250, // تحديد الارتفاع المناسب
                      width: double.infinity,
                    )
                  : _buildErrorImage(), // التعامل مع الصورة الغير موجودة
            ),
            const SizedBox(height: 30),

            // معلومات الحيوان الأليف
            _buildPetInfoRow("Name", pet.name, "Gender", pet.gender),
            const SizedBox(height: 20),
            _buildPetInfoRow("Age", pet.species.toString(), "Type", pet.breed),
            const SizedBox(height: 30),

            // خيارات التبديل
            _buildSwitchRow("Adoption"),
            const SizedBox(height: 20),
            _buildSwitchRow("Mating"),

            // زر التعديل
            const SizedBox(height: 30), // لإعطاء مساحة للزر
            Align(
              alignment: Alignment.bottomRight,
              child: AppButton(
                text: 'Edit',
                border: 10,
                backgroundColor: kProducPriceColor,
                width: 120,
                style: Styles.textStyleQui24.copyWith(color: Colors.white),
                onTap: () {
                  GoRouter.of(context).go(
                    AppRouter.kEditPet,
                    extra: pet, // إرسال البيانات إلى صفحة التعديل
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetInfoRow(
      String title1, String value1, String title2, String value2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildInfoNotebookStyle(title1, value1)),
        const SizedBox(width: 45),
        Expanded(child: _buildInfoNotebookStyle(title2, value2)),
      ],
    );
  }

  Widget _buildInfoNotebookStyle(String title, String value) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // header
            title,
            style: Styles.textStyleCom18.copyWith(
              color: kAddPetTextColor,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Styles.textStyleCom28.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }

  // بناء صف للتحويل بين التبديلات
  Widget _buildSwitchRow(String label) {
    return Row(
      children: [
        Text(
          label,
          style: Styles.textStyleCom28.copyWith(color: kAddPetTextColor),
        ),
        const Spacer(),
        const AppSwitch(),
      ],
    );
  }

  // في حالة وجود خطأ في الصورة
  Widget _buildErrorImage() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(
        Icons.error,
        color: Colors.red,
        size: 50,
      ),
    );
  }
}
