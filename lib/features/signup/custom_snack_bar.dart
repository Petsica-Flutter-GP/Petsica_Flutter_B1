import 'package:flutter/material.dart';
import 'package:petsica/core/utils/styles.dart';

void showCustomSnackBar(BuildContext context, String message, {bool success = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: success ? Colors.green.shade600 : Colors.red.shade600,
      duration: const Duration(seconds: 2),
      content: Row(
        children: [
          Icon(
            success ? Icons.check_circle : Icons.error,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
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
}
