import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/core/utils/token_decoder.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/input_field.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/sign_word.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/features/registeration/presentation/views/widgets/password_field.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/services/signup/auth_service_login.dart';

class WelcomeBackViewBody extends StatefulWidget {
  final String selectedOption;

  const WelcomeBackViewBody({super.key, required this.selectedOption});

  @override
  State<WelcomeBackViewBody> createState() => _WelcomeBackViewBodyState();
}

class _WelcomeBackViewBodyState extends State<WelcomeBackViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final response = await AuthService.login(email, password);

    if (response != null) {
      await TokenStorage.saveTokens(
        accessToken: response.token,
        refreshToken: response.refreshToken,
      );
      final roles = TokenDecoder.getRoles(response.token);
      final userId = TokenDecoder.getUserId(response.token);

      print('✅ Logged in as: $email');
      print('🆔 User ID: $userId');
      print('👥 Roles: $roles');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Logged in successfully!")),
      );

      // ✅ Navigate based on role using go_router
      if (roles.contains("Admin")) {
        context.go('/adminDashboard');
      } else {
        // context.go(AppRouter.kPost);
        // context.go(AppRouter.kStore);
        // context.go(AppRouter.kSellerMyStore);
        context.go(AppRouter.kSellerProfile);
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Login failed. Please try again.")),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          Center(
            child: Column(
              children: [
                Text(
                  "Welcome Back , name!",
                  style: Styles.textStyleQu28.copyWith(color: kWordColor),
                ),
                const SizedBox(height: 8),
                Text(
                  "Please login to continue",
                  style: Styles.textStyleCom18.copyWith(color: kWordColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 37),
                    InputField(
                      label: 'Email',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 29),
                    PasswordField(
                      text: 'Password',
                      controller: _passwordController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget Password?",
                          style:
                              Styles.textStyleCom12.copyWith(color: kWordColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 33),
                    AppButton(
                      text: _isLoading ? "Logging in..." : "Login",
                      border: 20,
                      onTap: _isLoading ? null : _handleLogin,

                      // onTap: () {
                      //   GoRouter.of(context).go(
                      //     AppRouter.kSellerMyStore,
                      //   );
                      // },
                    ),
                    SignupWord(
                      text1: "Don’t have an account?",
                      text2: "Sign Up",
                      userType: widget.selectedOption,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
