import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClinicListScreen extends StatelessWidget {
  const ClinicListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('قائمة العيادات')),
      body: ListView.builder(
        itemCount: 10, // عدد العيادات
        itemBuilder: (context, index) {
          // بيانات العيادة (الـ ClinicReceiverID و ClinicSenderID هنا يتم تحديدهم حسب الحالة)
          const clinicReceiverId = '1ef7bbb2-3e18-483a-a99d-3ace6dd5e046';
          const clinicSenderId = 'f7c5edf4-e962-46fa-a07e-5b761afb163d';

          return ListTile(
            title: Text('عيادة ${index + 1}'),
            onTap: () {
              // عند الضغط على العنصر، التوجه إلى صفحة ChatScreen مع نقل الـ IDs
              context.goNamed(
                'chat', // اسم المسار الذي حددته في GoRoute لصفحة الدردشة
                queryParameters: {
                  'receiverId': clinicReceiverId,
                  'senderId': clinicSenderId,
                },
              );
            },
          );
        },
      ),
    );
  }
}
