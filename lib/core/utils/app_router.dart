import 'package:go_router/go_router.dart';
import 'package:petsica/features/chatt/chatapp.dart';
import 'package:petsica/features/community/views/adoption_view.dart';
import 'package:petsica/features/community/views/clinic_view.dart';
import 'package:petsica/features/community/views/home_page.dart';
import 'package:petsica/features/community/views/mating_view.dart';
import 'package:petsica/features/community/views/publish_post_view.dart';
import 'package:petsica/core/utils/home.dart';
import 'package:petsica/features/chatBoot/views/chat_boot_onboarding_view.dart';
import 'package:petsica/features/chatBoot/views/chat_boot_view.dart';
import 'package:petsica/features/community/views/sitter_view.dart';
import 'package:petsica/features/profiles/adminn/view/admin_clinic_requests_view.dart';
import 'package:petsica/features/profiles/adminn/view/admin_all_orders_view.dart';
import 'package:petsica/features/profiles/adminn/view/admin_profile_view.dart';
import 'package:petsica/features/profiles/adminn/view/admin_seller_orders_view.dart';
import 'package:petsica/features/profiles/adminn/view/admin_seller_requests_view.dart';
import 'package:petsica/features/profiles/adminn/view/admin_seller_request_details_view.dart';
import 'package:petsica/features/profiles/adminn/view/admin_sitter_requests_view.dart';
import 'package:petsica/features/profiles/adminn/view/choose_order_screen_view.dart';
import 'package:petsica/features/profiles/adminn/widget/admin_settings_page.dart';
import 'package:petsica/features/profiles/clinic/view/clinic_edit_pet_view.dart';
import 'package:petsica/features/profiles/clinic/view/clinic_my_pet_view.dart';
import 'package:petsica/features/profiles/clinic/view/clinic_add_pet_view.dart';
import 'package:petsica/features/profiles/clinic/widget/clinic_settings_page.dart';
import 'package:petsica/features/profiles/edit.dart';
import 'package:petsica/features/profiles/model/get_pet_model.dart';
import 'package:petsica/features/profiles/seller/view/seller_add_product_view.dart';
import 'package:petsica/features/profiles/seller/view/seller_edit_pet_view.dart';
import 'package:petsica/features/profiles/seller/view/seller_edit_product_view.dart';
import 'package:petsica/features/profiles/seller/view/seller_my_pet_view.dart';
import 'package:petsica/features/profiles/seller/view/seller_my_store_view.dart';
import 'package:petsica/features/profiles/seller/view/seller_order_details_view.dart';
import 'package:petsica/features/profiles/seller/view/seller_orders_view.dart';
import 'package:petsica/features/profiles/seller/view/seller_pet_details_view.dart';
import 'package:petsica/features/profiles/seller/view/seller_add_pet_view.dart';
import 'package:petsica/features/profiles/seller/widget/seller_settings_page.dart';
import 'package:petsica/features/profiles/sitter/view/sitter_edit_pet_view.dart';
import 'package:petsica/features/profiles/sitter/view/sitter_my_pet_view.dart';
import 'package:petsica/features/profiles/sitter/view/sitter_my_services_view.dart';
import 'package:petsica/features/profiles/sitter/view/sitter_new_services_view.dart';
import 'package:petsica/features/profiles/sitter/view/sitter_edit_services_view.dart';
import 'package:petsica/features/profiles/sitter/view/sitter_pet_details_view.dart';
import 'package:petsica/features/profiles/sitter/view/sitter_profile_view.dart';
import 'package:petsica/features/profiles/sitter/widget/sitter_settings_page.dart';
import 'package:petsica/features/profiles/views/add_pet_view.dart';
import 'package:petsica/features/profiles/views/edit_pet_view.dart';
import 'package:petsica/features/profiles/user/views/user_profile_view.dart';
import 'package:petsica/features/profiles/user/widgets/user_settings_page.dart';
import 'package:petsica/features/profiles/where.dart';

import 'package:petsica/features/profiles/widgets/edit_profile.dart';
import 'package:petsica/features/reminder/reminder_view.dart';

import 'package:petsica/features/signup/presentation/views/seller/seller_signup_view.dart';
import 'package:petsica/features/signup/presentation/views/user/user_signup_view.dart';
import 'package:petsica/features/splash/presentation/views/widgets/splach_screen.dart';
import 'package:petsica/features/onboarding/presentation/views/onboarding.dart';
import 'package:petsica/features/Login/presentation/views/login_view.dart';
import 'package:petsica/features/store/views/cart_view.dart';
import 'package:petsica/features/store/views/checkout_view.dart';
import 'package:petsica/features/store/views/order_details_view.dart';
import 'package:petsica/features/store/views/product_details_view.dart';
import 'package:petsica/features/who/presentation/views/who_view.dart';
import '../../features/profiles/clinic/view/clinic_pet_details_view.dart';
import '../../features/profiles/clinic/view/clinic_profile_view.dart';
import '../../features/profiles/seller/view/seller_profile_view.dart';
import '../../features/profiles/views/my_pet_view.dart';
import '../../features/profiles/views/pet_details_view.dart';
import '../../features/signup/presentation/views/clinic/clinic_signup_view.dart';
import '../../features/signup/presentation/views/sitter/sitter_signup_view.dart';
import '../../features/store/views/store_view.dart';

abstract class AppRouter {
  //onboarding
  static const kOnboarding = '/onboarding';
  static const kWhoAreYou = '/whoAreYou';
  static const kWelcomeBack = '/welcomeBack';

  //user
  static const kUserSignUp = '/userSignUp';
  static const kUserProfile = '/userProfile';
  static const kUserSettings = '/userSettings';

  // pets part
  static const kMyPet = '/myPet';
  static const kPetDetails = '/petDetails';
  static const kEditPet = '/editPet';
  static const kAddPet = '/addPet';

  //seller
  static const kSellerSignUp = '/sellerSignUp';
  static const kSellerProfile = '/sellerProfile';
  static const kSellerMyStore = '/sellerMyStore';
  static const kSellerAddProduct = '/sellerAddProduct';
  static const kSellerEditProduct = '/sellerEditProduct';
  static const kSellerOrders = '/sellerOrders';
  static const kSellerOrderDetails = '/sellerOrderDetails';
  static const kSellerSettings = '/sellerSettings';

  //sitter
  static const kSitterSignUp = '/sitterSignUp';
  static const kSitterProfile = '/sitterProfile';
  static const kSitterSettings = '/sitterSettings';
  static const kSitterMyServices = '/sitterMyServices';
  static const kSitterNewServices = '/sitterNewServices';
  static const kSitterEditServices = '/sitterEditServices';

  //clinic
  static const kClinicSignUp = '/clinicSignUp';
  static const kClinicProfile = '/clinicProfile';
  static const kClinicSettings = '/clinicSettings';

  //admin
  static const kAdminProfile = '/adminProfile';
  static const kAdminSettings = '/adminSettings';
  static const kAdminSellerRequests = '/adminStoreRequests';
  static const kAdminClinicRequests = '/adminClinicRequests';
  static const kAdminSitterRequests = '/adminSitterRequests';
  static const kAdminRequestDetails = '/adminRequestDetails';
  static const kAdminAllOrders = '/adminAllOrders';
  static const kAdminSellerOrders = '/adminSellerOrders';

  //store
  static const kStore = '/store';
  static const kProductDetails = '/productDetails';
  static const kCart = '/cart';
  static const kCheckOut = '/checkOut';
  static const kOrderDetails = '/orderDetaild';

//chat-boot
  static const kChatBootOnboarding = '/chatBootOnboarding';
  static const kChatBoot = '/chatBoot';

//chat
  static const kSignalRChatApp = '/signalRChatApp';

  //community
  static const kCommunityChat = '/communityChat';
  static const kPost = '/Post';
  static const KHome = '/home';
  static const KAdoption = '/adoption';
  static const KMating = '/mating';
  static const KSitters = '/sitters';
  static const KClinics = '/clinics';
  static const KReminder = '/reminder';

  //other
  static const kWhereProfile = '/whereProfile';
  static const kWhoEdit = '/whoEdit';
  static const kHomeScreen = '/homeScreen';
  static const kEditProfile = '/editProfile';
  static const kChooseOrderScreen = '/chooseOrderScreen';

  //routes
  static final router = GoRouter(

     initialLocation: '/', // البداية من SplashScreen
    //initialLocation: kWelcomeBack,
    //  initialLocation: '/', // البداية من SplashScreen

    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: kSignalRChatApp,
        builder: (context, state) => const SignalRChatApp(),
      ),
      GoRoute(
        path: kOnboarding,
        builder: (context, state) => const Onboarding(),
      ),
      GoRoute(
        path: kCheckOut,
        builder: (context, state) => const CheckOutView(),
      ),
      GoRoute(
        path: kHomeScreen,
        builder: (context, state) => const HomeScreen(),
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
          final productId = state.extra as int; // نأخذ المنتج ID من extra
          return ProductDetailsView(
              productId: productId); // نمرره في الـ constructor
        },
      ),

      GoRoute(
        path: kOrderDetails,
        builder: (context, state) {
          final orderID = state.extra as int;
          return OrderDetailsView(orderID: orderID);
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
      GoRoute(
        path: kMyPet,
        builder: (context, state) => const MyPetView(),
      ),

      GoRoute(
        path: kPetDetails,
        builder: (context, state) {
          final pet = state.extra as GetPetModel;
          return PetDetailsView(pet: pet);
        },
      ),
      GoRoute(
        path: kEditPet,
        builder: (context, state) => const EditPetView(),
      ),

      GoRoute(
        path: kAddPet,
        builder: (context, state) => const AddPetView(),
      ),

      GoRoute(
        path: kPost,
        builder: (context, state) => const PublishPostView(),
      ),

      GoRoute(
        path: KHome,
        builder: (context, state) => const HomePage(),

      ),
      GoRoute(
        path: KAdoption,
        builder: (context, state) => const PetAdoptionPage(),

      ),
      GoRoute(
        path: KMating,
        builder: (context, state) => const PetMatingPage(),

      ),
      GoRoute(
        path: KSitters,
        builder: (context, state) => const PetSitterPage(),

      ),
      GoRoute(
        path: KClinics,
        builder: (context, state) => const ClinicsPage(),

      ),
      GoRoute(
        path: KReminder,
        builder: (context, state) => const ReminderApp(),

      ),
     

      GoRoute(
        path: kUserSettings,
        builder: (context, state) => const UserSettingsScreen(),
      ),
      GoRoute(
        path: kSitterSettings,
        builder: (context, state) => const SitterSettingsScreen(),
      ),
      GoRoute(
        path: kSellerSettings,
        builder: (context, state) => const SellerSettingsScreen(),
      ),
      GoRoute(
        path: kClinicSettings,
        builder: (context, state) => const ClinicSettingsScreen(),
      ),
      GoRoute(
        path: kAdminSettings,
        builder: (context, state) => const AdminSettingsScreen(),
      ),
      GoRoute(
        path: kAdminAllOrders,
        builder: (context, state) => const AdminAllOrdersView(),
      ),
      GoRoute(
        path: kAdminSellerOrders,
        builder: (context, state) => const AdminSellerOrdersView(),
      ),
      GoRoute(
        path: kChooseOrderScreen,
        builder: (context, state) => const ChooseOrderScreen(),
      ),
      GoRoute(
        path: kSitterMyServices,
        builder: (context, state) => const SitterMyServicesView(),
      ),
      GoRoute(
        path: kSitterNewServices,
        builder: (context, state) => const SitterNewServicesView(),
      ),
      GoRoute(
        path: kSitterEditServices,
        builder: (context, state) => const SitterEditServicesView(),
      ),
      GoRoute(
        path: kSellerMyStore,
        builder: (context, state) => const SellerMyStoreView(),
      ),
      GoRoute(
        path: kSellerEditProduct,
        builder: (context, state) {
          final productId = state.extra as int;
          return SellerEditProductView(productId: productId);
        },
      ),

      GoRoute(
        path: kSellerAddProduct,
        builder: (context, state) => const SellerAddProductView(),
      ),
      GoRoute(
        path: kSellerOrders,
        builder: (context, state) => const SellerOrdersView(),
      ),
      GoRoute(
        path: kSellerOrderDetails,
        builder: (context, state) {
          final orderId = state.extra as int;
          return SellerOrdersDetailsView(orderId: orderId);
        },
      ),

      GoRoute(
        path: kAdminSellerRequests,
        builder: (context, state) => const AdminSellerRequestsView(),
      ),
      GoRoute(
        path: kAdminSitterRequests,
        builder: (context, state) => const AdminSitterRequestsView(),
      ),
      GoRoute(
        path: kAdminClinicRequests,
        builder: (context, state) => const AdminClinicRequestsView(),
      ),
      GoRoute(
        path: kAdminRequestDetails,
        builder: (context, state) => const AdminSellerRequestDetailsView(),
      ),
      GoRoute(
        path: kChatBootOnboarding,
        builder: (context, state) => const ChatBootOnboardingView(),
      ),
      GoRoute(
        path: kChatBoot,
        builder: (context, state) => const ChatBootView(),
      ),
      GoRoute(
        path: kEditProfile,
        builder: (context, state) =>  EditProfileView(),
      ),
//       GoRoute(
//   path: kChat,
//   builder: (context, state) {
//     final data = state.extra as Map<String, String>;
//     return ChatView(
//       senderId: data['senderId']!,
//       receiverId: data['receiverId']!,
//     );
//   },
// ),
// GoRoute(
//         path: '/chat',
//         name: 'chat',
//         builder: (context, state) {
//           final receiverId = state.uri.queryParameters['receiverId']!;
//           final senderId = state.uri.queryParameters['senderId']!;
//           return CChatScreen(receiverId: receiverId, senderId: senderId);
//         },),
    ],
  );
}
