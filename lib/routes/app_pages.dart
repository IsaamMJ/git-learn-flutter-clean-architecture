import 'package:get/get.dart';
import '../presentation/pages/login.dart';
import '../presentation/pages/home.dart';
import '../presentation/bindings/home_binding.dart';
import '../presentation/pages/api_data.dart';
import '../presentation/bindings/api_data_binding.dart';
import '../presentation/bindings/login_binding.dart';
import '../routes/app_routes.dart';
import '../presentation/pages/main_navigation.dart';

class AppPages {
  static final pages = [
    // Login Page
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.fade,
    ),

    // Home Page
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),

    // Main Navigation
    GetPage(
      name: AppRoutes.main,
      page: () => const MainNavigationScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.apiData,

      page: () => const ApiDataPage(),
      binding: ApiDataBinding(),
    ),
  ];
}
