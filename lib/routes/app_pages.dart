import 'package:get/get.dart';
import 'package:untitled/presentation/bindings/splash_binding.dart';
import '../presentation/pages/splash.dart';
import '../presentation/pages/login.dart';
import '../presentation/pages/main_navigation.dart';
import '../presentation/bindings/login_binding.dart';
import '../presentation/bindings/home_binding.dart';
import '../routes/app_routes.dart';
import '../presentation/pages/car_detail.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainNavigationScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.carDetail,
      page: () {
        final carId = Get.arguments as String;
        return CarDetailPage(carId: carId);
      },
    ),
  ];
}
