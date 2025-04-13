import 'package:flutter/material.dart';

Future<dynamic> AdminRequestDeletionShowDialog(
    BuildContext context, VoidCallback onDelete) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm Deletion"),
      content: const Text("Are you sure you want to delete this product?"),
      actions: [
        // زر الإلغاء
        TextButton(
          onPressed: () {
            Navigator.pop(context); // إغلاق النافذة بدون حذف
          },
          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
        ),

        // زر الحذف
        TextButton(
          onPressed: () {
            Navigator.pop(context); // إغلاق النافذة
            onDelete(); // تنفيذ عملية الحذف

            // ✅ إظهار رسالة نجاح ✅
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Deleted successfully!"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
