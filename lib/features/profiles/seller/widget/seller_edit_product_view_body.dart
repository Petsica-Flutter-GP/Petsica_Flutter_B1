import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/seller/cubit/editproduct/edit_product_cubit.dart';
import 'package:petsica/features/profiles/seller/services/product_services.dart';
import 'package:petsica/features/profiles/seller/widget/seller_camera_placeholder.dart';
import 'package:petsica/features/profiles/widgets/app_drop_down_button.dart';
import 'package:petsica/features/Login/presentation/views/widgets/input_field.dart';

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

  File? _selectedImage;
  bool isImageRequired = false;

  // ✨ القيمتين اللي هنستلمهم من الـ GET
  String? sellerId;
  bool? isAvailable;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController();
    priceController = TextEditingController();
    quanController = TextEditingController();
    discountController = TextEditingController();
    descriptionController = TextEditingController();
    photoController = TextEditingController();
    categoryValue = "Food";

    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    try {
      final allProducts = await ProductService.getSellerProducts();
      final product =
          allProducts.firstWhere((p) => p.productId == widget.productId);

      setState(() {
        productNameController.text = product.productName;
        priceController.text = product.price.toString();
        quanController.text = product.quantity.toString();
        discountController.text = product.discount.toString();
        descriptionController.text = product.description;
        photoController.text = product.photo;
        categoryValue = product.category;

        sellerId = product.sellerId;
        isAvailable = product.isAvailable;
      });
    } catch (e) {
      log("Error fetching product: $e");
    }
  }

  @override
  void dispose() {
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
      create: (_) => EditProductCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Product", style: Styles.textStyleQu28),
          centerTitle: true,
          leading: const AppArrowBack(destination: AppRouter.kSellerMyStore),
        ),
        body: SingleChildScrollView(
          // Wrap the whole body in SingleChildScrollView
          child: Column(
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
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
                      const SizedBox(height: 25),
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
                        items:
                            ProductCategory.values.map((e) => e.name).toList(),
                        value: categoryValue,
                        onChanged: (String? newCategory) {
                          setState(() {
                            categoryValue = newCategory ?? categoryValue;
                          });
                        },
                      ),
                      const SizedBox(height: 45),
                      BlocConsumer<EditProductCubit, EditProductState>(
                        listener: (context, state) {
                          if (state is EditProductSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Product updated successfully')),
                            );
                          } else if (state is EditProductFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is EditProductLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return AppButton(
                            text: 'Save Changes',
                            border: 10,
                            onTap: () {
                              if (sellerId == null || isAvailable == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Product data is not loaded yet')),
                                );
                                return;
                              }

                              // تحقق من الحقول الفارغة
                              if (productNameController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Please enter a product name')),
                                );
                                return;
                              }

                              final price =
                                  double.tryParse(priceController.text);
                              if (price == null || price <= 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Please enter a valid price')),
                                );
                                return;
                              }

                              if (discountController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please enter a discount')),
                                );
                                return;
                              }

                              final discount =
                                  double.tryParse(discountController.text);
                              if (discount == null ||
                                  discount < 0 ||
                                  discount > 100) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Discount must be between 0 and 100')),
                                );
                                return;
                              }

                              // تحقق من أن الخصم لا يتجاوز السعر
                              if (discount > price) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Discount cannot be greater than price')),
                                );
                                return;
                              }

                              if (quanController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please enter a quantity')),
                                );
                                return;
                              }

                              final quantity =
                                  int.tryParse(quanController.text);
                              if (quantity == null || quantity <= 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please enter a valid quantity')),
                                );
                                return;
                              }

                              if (descriptionController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Please enter a description')),
                                );
                                return;
                              }

                              final photoToSend = _selectedImage != null
                                  ? base64Encode(
                                      _selectedImage!.readAsBytesSync())
                                  : photoController.text;

                              context.read<EditProductCubit>().editProduct(
                                    productId: widget.productId,
                                    productName: productNameController.text,
                                    price: price,
                                    discount: discount,
                                    description: descriptionController.text,
                                    quantity: quantity,
                                    photo: photoToSend,
                                    category:
                                        ProductCategoryExtension.fromString(
                                            categoryValue),
                                    sellerId: sellerId!,
                                    isAvailable: isAvailable!,
                                  );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
