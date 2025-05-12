import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/features/store/services/order_services.dart';
import '../../../core/utils/app_button.dart';
import '../../../../../core/constants.dart';

class AddressInputField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const AddressInputField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<AddressInputField> createState() => _AddressInputFieldState();
}

class _AddressInputFieldState extends State<AddressInputField> {
  bool _isRequired = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        minLines: 1,
        maxLines: widget.keyboardType == TextInputType.text ? 5 : 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: kInputFieldBackgroundColor,
          labelText: widget.label,
          labelStyle: GoogleFonts.comfortaa(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: kInputWordColor,
          ),
          floatingLabelStyle: const TextStyle(
            color: kBurgColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: kStorkTextFieldColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: kBurgColor,
              width: 2,
            ),
          ),
          errorText: _isRequired ? 'This field is required' : null,
        ),
      ),
    );
  }

  void validate() {
    setState(() {
      _isRequired = widget.controller?.text.trim().isEmpty ?? true;
    });
  }
}

/// 📍 Dialog to Confirm Address and Phone Number
Future<dynamic> showDialogMessageCart(BuildContext context) {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<_AddressInputFieldState> addressFieldKey =
      GlobalKey<_AddressInputFieldState>();
  final GlobalKey<_AddressInputFieldState> phoneFieldKey =
      GlobalKey<_AddressInputFieldState>();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          "Enter your address and phone number",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddressInputField(
              key: addressFieldKey,
              label: "Your Address",
              controller: addressController,
            ),
            const SizedBox(height: 10),
            AddressInputField(
              key: phoneFieldKey,
              label: "Phone Number",
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          Center(
            child: AppButton(
              text: "Confirm",
              border: 10,
              width: 160,
              height: 55,
              onTap: () async {
                final address = addressController.text.trim();
                final phoneNumber = phoneController.text.trim();

                // ✅ استدعاء التحقق للحقلين
                addressFieldKey.currentState?.validate();
                phoneFieldKey.currentState?.validate();

                if (address.isEmpty || phoneNumber.isEmpty) {
                  // لا تغلق الديالوج، ولكن بيّن الخطأ
                  return;
                }

                try {
                  await OrderService.makeOrder(address, phoneNumber);
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("✅ Order confirmed successfully!"),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );

                  GoRouter.of(context).go(AppRouter.kCheckOut);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('❌ Failed to confirm order: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      );
    },
  );
}
