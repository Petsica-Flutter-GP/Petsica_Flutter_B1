// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:petsica/core/utils/app_button.dart';
// import 'package:petsica/core/utils/styles.dart';
// import 'package:petsica/services/signup/otp_confirm_service.dart';
// import 'package:petsica/features/signup/presentation/widgets/phone_number_input_field.dart';
// import 'package:petsica/services/signup/resend_otp_service.dart';

// class OtpVerificationView extends StatefulWidget {
//   final String email;
//   const OtpVerificationView({super.key, required this.email});

//   @override
//   State<OtpVerificationView> createState() => _OtpVerificationViewState();
// }

// class _OtpVerificationViewState extends State<OtpVerificationView> {
//   final TextEditingController _otpController = TextEditingController();
//   bool _isVerifying = false;

//   Future<void> _verifyOtp() async {
//     final code = _otpController.text.trim();
//     if (code.length != 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter a valid 6-digit code")),
//       );
//       return;
//     }

//     setState(() => _isVerifying = true);

//     final result = await OtpConfirmService.otpConfirm(
//       email: widget.email,
//       otp: code,
//     );

//     setState(() => _isVerifying = false);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(result["message"]),
//         backgroundColor: result["success"] ? Colors.green : Colors.red,
//       ),
//     );

//     if (result["success"]) {
//       // Navigate to login or home if needed
//     }
//   }

//   Future<void> _resendOtp() async {
//     final result = await OtpResend.otpResend(email: widget.email);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(result["message"]),
//         backgroundColor: result["success"] ? Colors.green : Colors.red,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Enter the 6-digit code sent to ${widget.email}",
//               style: Styles.textStyleCom18.copyWith(color: Colors.black54),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 32),
//             PhoneNumberInputField(
//               label: "OTP Code",
//               controller: _otpController,
//               inputType: TextInputType.number,
//               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//               maxLength: 6,
//             ),
//             const SizedBox(height: 24),
//             _isVerifying
//                 ? const CircularProgressIndicator()
//                 : AppButton(
//                     text: "Verify",
//                     border: 20,
//                     onTap: _verifyOtp,
//                   ),
//             const SizedBox(height: 20),
//             TextButton(
//               onPressed: _resendOtp,
//               child: const Text("Resend OTP"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
