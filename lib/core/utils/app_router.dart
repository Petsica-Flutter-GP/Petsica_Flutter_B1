import 'package:go_router/go_router.dart';
import 'package:petsica/features/profiles/adminn/view/admin_profile_view.dart';
import 'package:petsica/features/profiles/sitter/view/sitter_profile_view.dart';
import 'package:petsica/features/profiles/user/views/user_profile_view.dart';
import 'package:petsica/features/profiles/where.dart';
import 'package:petsica/features/signup/presentation/views/seller/seller_signup_view.dart';
import 'package:petsica/features/signup/presentation/views/user/user_signup_view.dart';

import 'package:petsica/features/splash/presentation/views/widgets/splach_screen.dart';
import 'package:petsica/features/onboarding/presentation/views/onboarding.dart';
import 'package:petsica/features/registeration/presentation/views/welcome_back_view.dart';
import 'package:petsica/features/store/views/cart_view.dart';
import 'package:petsica/features/store/views/product_details_view.dart';
import 'package:petsica/features/store/widgets/product_details_view_body.dart';
import 'package:petsica/features/store/widgets/store_view_body.dart';
import 'package:petsica/features/who/presentation/views/who_view.dart';

import '../../features/profiles/clinic/view/clinic_profile_view.dart';
import '../../features/profiles/seller/view/seller_profile_view.dart';
import '../../features/signup/presentation/views/clinic/clinic_signup_view.dart';
import '../../features/signup/presentation/views/sitter/sitter_signup_view.dart';
import '../../features/store/views/store_view.dart';

abstract class AppRouter {
  static const kOnboarding = '/onboarding';
  static const kWhoAreYou = '/whoAreYou';
  static const kWelcomeBack = '/welcomeBack';
  static const kUserSignUp = '/userSignUp';
  static const kClinicSignUp = '/clinicSignUp';
  static const kSitterSignUp = '/sitterSignUp';
  static const kSellerSignUp = '/sellerSignUp';
  static const kStore = '/store';
  static const kProductDetails = '/productDetails';
  static const kCart = '/cart';
  static const kUserProfile = '/userProfile';
  static const kSitterProfile = '/sitterProfile';
  static const kSellerProfile = '/sellerProfile';
  static const kClinicProfile = '/clinicProfile';
  static const kAdminProfile = '/adminProfile';
  static const kWhereProfile = '/whereProfile';

  static final router = GoRouter(
    // initialLocation: '/', // البداية من SplashScreen
    initialLocation: kWhereProfile,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: kOnboarding,
        builder: (context, state) => const Onboarding(),
      ),
      GoRoute(
        path: kWhoAreYou,
        builder: (context, state) => const WhoView(),
      ),
      GoRoute(
        path: kWelcomeBack,
        builder: (context, state) {
          final selectedOption = state.extra as String? ?? 'Unknown';
          return WelcomeBackView(selectedOption: selectedOption);
        },
      ),
      GoRoute(
        path: kUserSignUp,
        builder: (context, state) => const UserSignUpView(),
      ),
      GoRoute(
        path: kClinicSignUp,
        builder: (context, state) => const ClinicSignUpView(),
      ),
      GoRoute(
        path: kSellerSignUp,
        builder: (context, state) => const SellerSignUpView(),
      ),
      GoRoute(
        path: kSitterSignUp,
        builder: (context, state) => const SitterSignUpView(),
      ),
      GoRoute(
        path: kStore,
        builder: (context, state) => const StoreView(),
      ),
      GoRoute(
        path: kProductDetails,
        builder: (context, state) {
          final productData = state.extra as Map<String, dynamic>? ?? {};
          return ProductDetailsView(productData: productData);
        },
      ),
      GoRoute(
        path: kCart,
        builder: (context, state) => const CartView(),
      ),
      GoRoute(
        path: kUserProfile,
        builder: (context, state) => const UserProfileView(),
      ),
      GoRoute(
        path: kSitterProfile,
        builder: (context, state) => const SitterProfileView(),
      ),
      GoRoute(
        path: kSellerProfile,
        builder: (context, state) => const SellerProfileView(),
      ),
      GoRoute(
        path: kClinicProfile,
        builder: (context, state) => const ClinicProfileView(),
      ),
      GoRoute(
        path: kAdminProfile,
        builder: (context, state) => const AdminProfileView(),
      ),
      GoRoute(
        path: kWhereProfile,
        builder: (context, state) => const WhereProf(),
      ),
    ],
  );
}
