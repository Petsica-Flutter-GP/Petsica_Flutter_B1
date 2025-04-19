// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:petsica/core/utils/app_button.dart';
// import 'package:petsica/core/utils/app_arrow_back.dart';
// import 'package:petsica/core/utils/app_router.dart';
// import 'package:petsica/core/utils/styles.dart';
// import 'package:petsica/features/profiles/seller/cubit/add/add_product_cubit.dart';
// import 'package:petsica/features/profiles/seller/services/product_services.dart';
// import 'package:petsica/features/profiles/seller/widget/seller_camera_placeholder.dart';
// import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';
// import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
// import 'package:petsica/features/profiles/seller/cubit/add/add_product_cubit_state.dart';

// class SellerAddProductViewBody extends StatefulWidget {
//   const SellerAddProductViewBody({super.key});

//   @override
//   State<SellerAddProductViewBody> createState() =>
//       _SellerAddProductViewBodyState();
// }

// class _SellerAddProductViewBodyState extends State<SellerAddProductViewBody> {
//   final _formKey = GlobalKey<FormState>();
//   ProductCategory? category;

//   final nameController = TextEditingController();
//   final priceController = TextEditingController();
//   final discController = TextEditingController();
//   final quanController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final categoryController = TextEditingController();

//   File? _selectedImage;
//   bool isImageRequired = false; // تعريف متغير isImageRequired

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AddProductCubit(),
//       child: BlocConsumer<AddProductCubit, AddProductState>(
//         listener: (context, state) {
//           if (state is AddProductSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('✔️ Product added successfully')),
//             );
//             GoRouter.of(context).go(
//               AppRouter.kSellerMyStore,
//             );
//           } else if (state is AddProductError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('❌❌ ${state.message}')),
//             );
//           }
//         },
//         builder: (context, state) {
//           final cubit = context.read<AddProductCubit>();

//           return Scaffold(
//             appBar: AppBar(
//               title: Text("Add product", style: Styles.textStyleQu28),
//               centerTitle: true,
//               leading: const AppArrowBack(destination: AppRouter.kSellerMyStore),
//             ),
//             body: state is AddProductLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : SingleChildScrollView(
//                     child: _buildForm(context, cubit),
//                   ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildForm(BuildContext context, AddProductCubit cubit) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
//           child: SellerCameraPlaceholder(
//             onImageSelected: (image) {
//               setState(() {
//                 _selectedImage = image;
//                 isImageRequired =
//                     false; // تعيين isImageRequired عند اختيار صورة
//               });
//             },
//             onImageStatusChanged: (bool isSelected) {
//               setState(() {
//                 isImageRequired =
//                     !isSelected; // تغيير حالة isImageRequired بناءً على التحديد
//               });
//             },
//             isImageRequired: isImageRequired,
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 40),
//                   InputField(
//                     label: 'Product name',
//                     controller: nameController,
//                     validator: (value) => value!.isEmpty ? 'Required' : null,
//                     maxLength: 100,
//                   ),
//                   const SizedBox(height: 25),
//                   InputField(
//                     label: 'Price',
//                     controller: priceController,
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       final price = double.tryParse(value ?? '');
//                       if (price == null || price <= 0) {
//                         return 'Price must be greater than 0'; // تعديل هنا للتأكد من أن السعر أكبر من 0
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 40),
//                   InputField(
//                     label: 'Discount',
//                     controller: discController,
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Required';
//                       }
//                       final discount = double.tryParse(value);
//                       if (discount != null && discount < 0) {
//                         return 'Discount cannot be negative number';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 25),
//                   InputField(
//                     label: 'Quantity',
//                     controller: quanController,
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Required';
//                       }
//                       final quantity = int.tryParse(value);
//                       if (quantity != null && quantity <= 0) {
//                         return 'Quantity must be greater than 0';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 25),
//                   InputField(
//                     label: 'Description',
//                     controller: descriptionController,
//                     validator: (value) => value!.isEmpty ? 'Required' : null,
//                     maxLength: 500,
//                     maxLines: 5,
//                   ),
//                   const SizedBox(height: 25),
//                   AppDropDownButton(
//                     labelText: "Category",
//                     items: const ["Food", "Toys", "Accessories", "Healthcare"],
//                     value: category?.name ??
//                         "Food", // التأكد من أن القيمة هي String وليس ProductCategory
//                     onChanged: (newVal) {
//                       setState(() {
//                         category = ProductCategoryExtension.fromString(
//                             newVal!); // تحويل القيمة النصية إلى ProductCategory
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 30),
//                   AppButton(
//                       text: 'Add',
//                       border: 10,
//                       onTap: () async {
//                         if (_formKey.currentState!.validate()) {
//                           // التأكد من وجود الصورة إذا كانت لازمة
//                           if (_selectedImage == null) {
//                             setState(() {
//                               isImageRequired = true; // تحديد أن الصورة لازمة
//                             });
//                             return; // عدم إتمام العملية لو مفيش صورة
//                           }

//                           // التأكد من وجود فئة
//                           if (category == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('❌ Category is required')),
//                             );
//                             return; // التأكد من اختيار الفئة
//                           }

//                           final bytes = await _selectedImage!.readAsBytes();
//                           final base64Image = base64Encode(bytes);

//                           cubit.addProduct(
//                             name: nameController.text.trim(),
//                             price: double.parse(priceController.text),
//                             discount: double.parse(discController.text),
//                             description: descriptionController.text.trim(),
//                             quantity: int.parse(quanController.text),
//                             photo: base64Image,
//                             category:
//                                 category!, // القيمة الآن من النوع ProductCategory
//                           );
//                         }
//                       }),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/cubit/add/add_product_cubit.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/features/profiles/seller/widget/seller_camera_placeholder.dart';
import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/profiles/seller/cubit/add/add_product_cubit_state.dart';

class SellerAddProductViewBody extends StatefulWidget {
  const SellerAddProductViewBody({super.key});

  @override
  State<SellerAddProductViewBody> createState() =>
      _SellerAddProductViewBodyState();
}

class _SellerAddProductViewBodyState extends State<SellerAddProductViewBody> {
  final _formKey = GlobalKey<FormState>();
  ProductCategory? category;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final discController = TextEditingController();
  final quanController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();

  File? _selectedImage;
  bool isImageRequired = false;

  bool isLoading = false; // حالة التحميل

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: BlocConsumer<AddProductCubit, AddProductState>(
        listener: (context, state) {
          if (state is AddProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✔️ Product added successfully')),
            );

            // تصفير الحقول بعد النجاح
            nameController.clear();
            priceController.clear();
            discController.clear();
            quanController.clear();
            descriptionController.clear();
            categoryController.clear();
            setState(() {
              _selectedImage = null;
              category = null;
            });

            GoRouter.of(context).go(AppRouter.kSellerMyStore);
          } else if (state is AddProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('❌❌ ${state.message}')),
            );
            // تصفير الحقول في حالة الفشل (اختياري)
            nameController.clear();
            priceController.clear();
            discController.clear();
            quanController.clear();
            descriptionController.clear();
            categoryController.clear();
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddProductCubit>();

          return Scaffold(
            appBar: AppBar(
              title: Text("Add product", style: Styles.textStyleQu28),
              centerTitle: true,
              leading:
                  const AppArrowBack(destination: AppRouter.kSellerMyStore),
            ),
            body: state is AddProductLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: _buildForm(context, cubit),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, AddProductCubit cubit) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
          child: SellerCameraPlaceholder(
            onImageSelected: (image) {
              setState(() {
                _selectedImage = image;
                isImageRequired = false;
              });
            },
            onImageStatusChanged: (bool isSelected) {
              setState(() {
                isImageRequired = !isSelected;
              });
            },
            isImageRequired: isImageRequired,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  InputField(
                    label: 'Product name',
                    controller: nameController,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                    maxLength: 100,
                  ),
                  const SizedBox(height: 25),
                  InputField(
                    label: 'Price',
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final price = double.tryParse(value ?? '');
                      if (price == null || price <= 0) {
                        return 'Price must be greater than 0';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  InputField(
                    label: 'Discount',
                    controller: discController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      final discount = double.tryParse(value);
                      final price = double.tryParse(priceController.text);
                      if (discount != null && discount < 0) {
                        return 'Discount cannot be negative number';
                      }
                      if (discount != null &&
                          price != null &&
                          discount > price) {
                        return 'Discount cannot exceed price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  InputField(
                    label: 'Quantity',
                    controller: quanController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      final quantity = int.tryParse(value);
                      if (quantity != null && quantity <= 0) {
                        return 'Quantity must be greater than 0';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  InputField(
                    label: 'Description',
                    controller: descriptionController,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                    maxLength: 500,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 25),
                  AppDropDownButton(
                    labelText: "Category",
                    items: const ["Food", "Toys", "Accessories", "Healthcare"],
                    value: category?.name ?? "Food",
                    onChanged: (newVal) {
                      setState(() {
                        category = ProductCategoryExtension.fromString(newVal!);
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  AppButton(
                      text: isLoading ? 'Adding...' : 'Add',
                      border: 10,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_selectedImage == null) {
                            setState(() {
                              isImageRequired = true;
                            });
                            return;
                          }

                          if (category == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('❌ Category is required')),
                            );
                            return;
                          }

                          final bytes = await _selectedImage!.readAsBytes();
                          final base64Image = base64Encode(bytes);

                          setState(() {
                            isLoading = true;
                          });

                          await cubit.addProduct(
                            name: nameController.text.trim(),
                            price: double.parse(priceController.text.trim()),
                            discount: double.parse(discController.text.trim()),
                            description: descriptionController.text.trim(),
                            quantity: int.parse(quanController.text.trim()),
                            photo: base64Image,
                            category: category!,
                          );

                          setState(() {
                            isLoading = false;
                          });
                        }
                      }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
