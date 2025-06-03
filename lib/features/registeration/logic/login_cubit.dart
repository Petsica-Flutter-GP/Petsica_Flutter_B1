// import 'package:flutter_bloc/flutter_bloc.dart';

// // الحالات التي يمكن أن يمر بها Cubit
// abstract class LoginState {}

// class LoginInitial extends LoginState {}

// class PasswordVisibilityToggled extends LoginState {
//   final bool isVisible;
//   PasswordVisibilityToggled(this.isVisible);
// }

// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginInitial());

//   bool isPasswordVisible = false;

//   // تغيير حالة رؤية كلمة المرور
//   void togglePasswordVisibility() {
//     isPasswordVisible = !isPasswordVisible;
//     emit(PasswordVisibilityToggled(isPasswordVisible));
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // import '../../../logic/login_cubit.dart';

// // class LoginScreen extends StatelessWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (context) => LoginCubit(),
// //       child: Scaffold(
// //         backgroundColor: const Color(0xFFF0EAE3),
// //         body: Center(
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 24),
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // ✅ عنوان الترحيب
// //                 const Text(
// //                   "Welcome Back !",
// //                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 const Text(
// //                   "Please login to continue",
// //                   style: TextStyle(fontSize: 16, color: Colors.grey),
// //                 ),
// //                 const SizedBox(height: 32),

// //                 // ✅ حقل اسم المستخدم
// //                 TextField(
// //                   decoration: InputDecoration(
// //                     labelText: "Username",
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 16),

// //                 // ✅ حقل كلمة المرور مع BlocBuilder لإدارة الإخفاء/الإظهار
// //                 BlocBuilder<LoginCubit, LoginState>(
// //                   builder: (context, state) {
// //                     final cubit = context.read<LoginCubit>();
// //                     return TextField(
// //                       obscureText: !cubit.isPasswordVisible,
// //                       decoration: InputDecoration(
// //                         labelText: "Password",
// //                         border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                         suffixIcon: IconButton(
// //                           icon: Icon(
// //                             cubit.isPasswordVisible
// //                                 ? Icons.visibility
// //                                 : Icons.visibility_off,
// //                           ),
// //                           onPressed: () {
// //                             context
// //                                 .read<LoginCubit>()
// //                                 .togglePasswordVisibility();
// //                           },
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),

// //                 const SizedBox(height: 8),

// //                 // ✅ زر "هل نسيت كلمة المرور؟"
// //                 Align(
// //                   alignment: Alignment.centerRight,
// //                   child: TextButton(
// //                     onPressed: () {},
// //                     child: const Text("Forget Password?"),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 16),

// //                 // ✅ زر تسجيل الدخول
// //                 SizedBox(
// //                   width: double.infinity,
// //                   child: ElevatedButton(
// //                     onPressed: () {},
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFF7D1D1D),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                       padding: const EdgeInsets.symmetric(vertical: 16),
// //                     ),
// //                     child: const Text(
// //                       "Login",
// //                       style: TextStyle(fontSize: 18, color: Colors.white),
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 16),

// //                 // ✅ زر "لديك حساب بالفعل؟ سجل الآن"
// //                 Center(
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       const Text("Already have an account?"),
// //                       TextButton(
// //                         onPressed: () {},
// //                         child: const Text("Log in"),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
