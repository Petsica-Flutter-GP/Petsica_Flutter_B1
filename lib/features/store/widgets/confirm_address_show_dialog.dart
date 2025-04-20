import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/features/store/widgets/address_input_field.dart';

import '../../../core/utils/app_button.dart';

Future<dynamic> showDialogMessage(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text("Enter your address",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const AddressInputField(label: "Your Address"),
        actions: [
          Center(
            child: AppButton(
              text: "Confirm",
              border: 10,
              width: 160,
              height: 55,
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Confirmed successfully!"),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
                GoRouter.of(context).go(
                        AppRouter.kCheckOut,
                      );
              },
            ),
          )
        ],
      );
    },
  );
}
