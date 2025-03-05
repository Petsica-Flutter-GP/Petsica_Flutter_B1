import 'package:flutter/material.dart';
import 'styles.dart';

class SnackbarHelper {
  static OverlayEntry? _currentOverlay; // لتخزين الـ Snackbar الحالي

  static void show(BuildContext context, String message,
      {bool isError = false}) {
    // إغلاق أي Snackbar مفتوح حاليًا قبل عرض واحد جديد
    _removeCurrentSnackbar();

    final overlay = Overlay.of(context);
    _currentOverlay = OverlayEntry(
      builder: (context) => Positioned(
        top:
            MediaQuery.of(context).size.height * 0.4, // في منتصف الشاشة تقريبًا
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 300, // أقصى عرض
                minWidth: 200, // أقل عرض
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              decoration: BoxDecoration(
                color: isError
                    ? const Color.fromARGB(255, 200, 70, 70) // لون أحمر للفشل
                    : const Color.fromARGB(255, 76, 175, 80), // لون أخضر للنجاح
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isError ? Icons.error_outline : Icons.check_circle_outline,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: Styles.textStyleQu28.copyWith(
                        color: Colors.white, // لون النص أبيض ليتناسب مع الخلفية
                        fontSize: 16, // حجم النص متناسق
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // إدراج الـ Overlay
    overlay.insert(_currentOverlay!);

    // إزالة الـ Snackbar بعد 3 ثوانٍ
    Future.delayed(const Duration(seconds: 3), () {
      _removeCurrentSnackbar();
    });
  }

  // دالة لإزالة الـ Snackbar الحالي إن وجد
  static void _removeCurrentSnackbar() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}
