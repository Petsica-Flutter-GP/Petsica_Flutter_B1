// SitterNewServicesViewBody.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_arrow_back.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/profiles/sitter/cubit/addService/add_service_cubit.dart';
import 'package:petsica/features/profiles/sitter/cubit/addService/add_service_state.dart';
import 'package:petsica/features/Login/presentation/views/widgets/input_field.dart';
import '../../../../core/constants.dart';

class SitterNewServicesViewBody extends StatefulWidget {
  const SitterNewServicesViewBody({super.key});

  @override
  State<SitterNewServicesViewBody> createState() =>
      _SitterNewServicesViewBodyState();
}

class _SitterNewServicesViewBodyState extends State<SitterNewServicesViewBody> {
  final _typeController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _typeError;
  String? _priceError;
  String? _locationError;
  String? _deecription;

  @override
  void dispose() {
    _typeController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    final cubit = context.read<AddSitterServiceCubit>();

    final title = _typeController.text.trim();
    final priceText = _priceController.text.trim();
    final location = _locationController.text.trim();
    final description = _descriptionController.text.trim();

    setState(() {
      _typeError = title.isEmpty ? 'Required field' : null;
      _priceError = priceText.isEmpty ? 'Required field' : null;
      _locationError = location.isEmpty ? 'Required field' : null;
      _deecription = description.isEmpty ? 'Required field' : null;
    });

    if (_typeError != null || _priceError != null || _locationError != null) {
      _showErrorSnackBar('Please fill all required fields!');
      return;
    }

    final price = double.tryParse(priceText);
    if (price == null) {
      _showErrorSnackBar('Invalid price value!');
      return;
    }

    cubit.addService(
      title: title,
      price: price,
      description: description,
      location: location,
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildFieldWithError({
    required Widget inputField,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        inputField,
        AnimatedOpacity(
          opacity: errorText == null ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: errorText == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  child: Text(
                    errorText,
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 13,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddSitterServiceCubit, AddSitterServiceState>(
      listener: (context, state) {
        if (state is AddSitterServiceSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.green.shade600,
              duration: const Duration(seconds: 2),
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Service added successfully!',
                      style: Styles.textStyleCom16.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            GoRouter.of(context).go(AppRouter.kSitterMyServices);
          });
        } else if (state is AddSitterServiceFailure) {
          _showErrorSnackBar(state.error);
        }
      },
      child: Scaffold(
        backgroundColor: kWhiteGroundColor,
        appBar: AppBar(
          title: Text("Add New Service", style: Styles.textStyleQu28),
          centerTitle: true,
          leading: const AppArrowBack(destination: AppRouter.kSitterMyServices),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildFieldWithError(
                  inputField: InputField(
                    label: 'Service Title',
                    controller: _typeController,
                  ),
                  errorText: _typeError,
                ),
                const SizedBox(height: 30),
                _buildFieldWithError(
                  inputField: InputField(
                    label: 'Price per hour',
                    controller: _priceController,
                  ),
                  errorText: _priceError,
                ),
                const SizedBox(height: 30),
                _buildFieldWithError(
                  inputField: InputField(
                    label: 'Location',
                    controller: _locationController,
                  ),
                  errorText: _locationError,
                ),
                const SizedBox(height: 50),
                _buildFieldWithError(
                  inputField: InputField(
                    label: 'Description',
                    controller: _descriptionController,
                  ),
                  errorText: _locationError,
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.bottomRight,
                  child:
                      BlocBuilder<AddSitterServiceCubit, AddSitterServiceState>(
                    builder: (context, state) {
                      return AppButton(
                        text: state is AddSitterServiceLoading
                            ? 'Adding...'
                            : 'Add',
                        border: 10,
                        width: 120,
                        onTap: _submit,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
