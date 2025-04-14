  import 'package:get/get.dart';
  import '../presentation/pages/login.dart';
  import '../presentation/pages/main_navigation.dart';
  import '../presentation/pages/car_detail.dart';
  import '../presentation/bindings/login_binding.dart';
  import '../presentation/bindings/home_binding.dart';
  import '../presentation/bindings/car_detail_binding.dart';
  import '../routes/app_routes.dart';

  class AppPages {
    static final pages = [

      GetPage(
        name: AppRoutes.login,
        page: () => const LoginScreen(),
        binding: LoginBinding(),
        transition: Transition.fade,
      ),

      GetPage(
        name: AppRoutes.main,
        page: () {
          final tab = Get.arguments ?? 'home';
          return MainNavigationScreen(initialTab: tab);
        },
        binding: HomeBinding(),
      ),

      GetPage(
        name: '/car/:id',
        page: () => const CarDetailPage(),
        binding: CarDetailBinding(),
      ),
    ];
  }
