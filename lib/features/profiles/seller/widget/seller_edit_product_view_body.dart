import 'package:flutter/material.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/widget/seller_camera_placeholder.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';

import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/seller/cubit/updateP/update_product_cubit.dart';
import 'package:petsica/features/profiles/seller/cubit/updateP/update_product_state.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';

class SellerEditProductViewBody extends StatefulWidget {
  final int productId;

  const SellerEditProductViewBody({
    super.key,
    required this.productId,
  });

  @override
  _SellerEditProductViewBodyState createState() =>
      _SellerEditProductViewBodyState();
}

class _SellerEditProductViewBodyState extends State<SellerEditProductViewBody> {
  late TextEditingController productNameController;
  late TextEditingController priceController;
  late TextEditingController quanController;
  late TextEditingController discountController;
  late TextEditingController descriptionController;
  late TextEditingController photoController;
  late String categoryValue;

  File? _selectedImage; // متغير لحفظ الصورة المختارة
  bool isImageRequired = false; // متغير للتحقق من ضرورة الصورة

  @override
  void initState() {
    super.initState();
    // تعيين الحقول لتكون فارغة
    productNameController = TextEditingController();
    priceController = TextEditingController();
    quanController = TextEditingController();
    discountController = TextEditingController();
    descriptionController = TextEditingController();
    photoController = TextEditingController();
    categoryValue = "Food"; // تعيين الفئة لتكون فارغة
  }

  @override
  void dispose() {
    // تحرير الـ Controllers
    productNameController.dispose();
    priceController.dispose();
    quanController.dispose();
    discountController.dispose();
    descriptionController.dispose();
    photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdateProductCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Product", style: Styles.textStyleQu28),
          centerTitle: true,
          leading: const AppArrowBack(destination: AppRouter.kSellerMyStore),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
                child: Column(
                  children: [
                    SellerCameraPlaceholder(
                      onImageSelected: (image) {
                        setState(() {
                          _selectedImage = image;
                          isImageRequired =
                              false; // تعيين isImageRequired عند اختيار صورة
                        });
                      },
                      onImageStatusChanged: (bool isSelected) {
                        setState(() {
                          isImageRequired =
                              !isSelected; // تغيير حالة isImageRequired بناءً على التحديد
                        });
                      },
                      isImageRequired: isImageRequired,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        // إدخال الحقول مع الـ TextEditingController
                        InputField(
                          label: 'Product name',
                          controller: productNameController,
                        ),
                        const SizedBox(height: 25),
                        InputField(
                          label: 'Price',
                          controller: priceController,
                        ),
                        const SizedBox(height: 25),
                        InputField(
                          label: 'Discount',
                          controller: discountController,
                        ),
                        InputField(
                          label: 'Quantity',
                          controller: quanController,
                        ),
                        const SizedBox(height: 25),
                        InputField(
                          label: 'Description',
                          controller: descriptionController,
                        ),
                        const SizedBox(height: 25),
                        AppDropDownButton(
                          labelText: 'Category',
                          items: ProductCategory.values
                              .map((e) => e.name) // تأكد من أن هذه القيم فريدة
                              .toList(),
                          value: categoryValue.isNotEmpty
                              ? categoryValue
                              : ProductCategory
                                  .values.first.name, // تعيين قيمة افتراضية
                          onChanged: (String? newCategory) {
                            setState(() {
                              categoryValue = newCategory ?? categoryValue;
                            });
                          },
                        ),
                        const SizedBox(height: 45),
                        BlocConsumer<UpdateProductCubit, UpdateProductState>(
                          listener: (context, state) {
                            if (state is UpdateProductSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Product updated successfully')),
                              );
                            } else if (state is UpdateProductFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is UpdateProductLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return AppButton(
                              text: 'Save Changes',
                              border: 10,
                              onTap: () {
                                final photoToSend = _selectedImage != null
                                    ? base64Encode(
                                        _selectedImage!.readAsBytesSync())
                                    : photoController.text;

                                context
                                    .read<UpdateProductCubit>()
                                    .updateProduct(
                                      productId: widget.productId,
                                      productName: productNameController.text,
                                      price: double.parse(priceController.text),
                                      discount:
                                          double.parse(discountController.text),
                                      description: descriptionController.text,
                                      quantity: int.parse(quanController.text),
                                      photo: photoToSend,
                                      category:
                                          ProductCategoryExtension.fromString(
                                              categoryValue),
                                    );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






/*

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/cubit/updateP/update_product_cubit.dart';
import 'package:petsica/features/profiles/seller/cubit/updateP/update_product_state.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/features/profiles/seller/widget/seller_camera_placeholder.dart';
import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';

class SellerEditProductViewBody extends StatefulWidget {
  final int productId;

  const SellerEditProductViewBody({
    super.key,
    required this.productId,
  });

  @override
  _SellerEditProductViewBodyState createState() =>
      _SellerEditProductViewBodyState();
}

class _SellerEditProductViewBodyState extends State<SellerEditProductViewBody> {
  late TextEditingController productNameController;
  late TextEditingController priceController;
  late TextEditingController quanController;
  late TextEditingController discountController;
  late TextEditingController descriptionController;
  late TextEditingController photoController;
  late String categoryValue;

  File? _selectedImage;  // متغير لحفظ الصورة المختارة
  bool isImageRequired = false; // متغير للتحقق من ضرورة الصورة

  @override
  void initState() {
    super.initState();
    // تعيين الحقول لتكون فارغة
    productNameController = TextEditingController();
    priceController = TextEditingController();
    quanController = TextEditingController();
    discountController = TextEditingController();
    descriptionController = TextEditingController();
    photoController = TextEditingController();
    categoryValue = ""; // تعيين الفئة لتكون فارغة
  }

  @override
  void dispose() {
    // تحرير الـ Controllers
    productNameController.dispose();
    priceController.dispose();
    quanController.dispose();
    discountController.dispose();
    descriptionController.dispose();
    photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdateProductCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Product", style: Styles.textStyleQu28),
          centerTitle: true,
          leading: const AppArrowBack(destination: AppRouter.kSellerMyStore),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
                  child: Column(
                    children: [
                      SellerCameraPlaceholder(
                        onImageSelected: (image) {
                          setState(() {
                            _selectedImage = image;
                            isImageRequired =
                                false; // تعيين isImageRequired عند اختيار صورة
                          });
                        },
                        onImageStatusChanged: (bool isSelected) {
                          setState(() {
                            isImageRequired =
                                !isSelected; // تغيير حالة isImageRequired بناءً على التحديد
                          });
                        },
                        isImageRequired: isImageRequired,
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        // إدخال الحقول مع الـ TextEditingController
                        InputField(
                          label: 'Product name',
                          controller: productNameController,
                        ),
                        const SizedBox(height: 25),
                        InputField(
                          label: 'Price',
                          controller: priceController,
                        ),
                        const SizedBox(height: 25),
                        InputField(
                          label: 'Discount',
                          controller: discountController,
                        ),
                        InputField(
                          label: 'Quantity',
                          controller: quanController,
                        ),
                        const SizedBox(height: 25),
                        InputField(
                          label: 'Description',
                          controller: descriptionController,
                        ),
                        const SizedBox(height: 25),
                        AppDropDownButton(
                          labelText: 'Category',
                          items: ProductCategory.values
                              .map((e) => e.name)
                              .toList(),
                          value: categoryValue,
                          onChanged: (String? newCategory) {
                            setState(() {
                              categoryValue = newCategory ?? categoryValue;
                            });
                          },
                        ),
                        const SizedBox(height: 45),
                        BlocConsumer<UpdateProductCubit, UpdateProductState>(
                          listener: (context, state) {
                            if (state is UpdateProductSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Product updated successfully')),
                              );
                            } else if (state is UpdateProductFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is UpdateProductLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return AppButton(
                              text: 'Save Changes',
                              border: 10,
                              onTap: () {
                                final photoToSend = _selectedImage != null
                                    ? base64Encode(_selectedImage!.readAsBytesSync())
                                    : photoController.text;

                                context
                                    .read<UpdateProductCubit>()
                                    .updateProduct(
                                      productId: widget.productId,
                                      productName: productNameController.text,
                                      price: double.parse(priceController.text),
                                      discount:
                                          double.parse(discountController.text),
                                      description: descriptionController.text,
                                      quantity: int.parse(quanController.text),
                                      photo: photoToSend,
                                      category:
                                          ProductCategoryExtension.fromString(
                                              categoryValue),
                                    );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



 */