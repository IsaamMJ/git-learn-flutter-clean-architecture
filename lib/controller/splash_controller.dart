import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../routes/app_routes.dart';
import '../../core/services/deep_link_service.dart';
import '../../core/utils/deeplink_handler.dart';
import '../presentation/pages/main_navigation.dart';

class SplashController extends GetxController {
  final HomeController homeCtrl = Get.find<HomeController>();
  final DeepLinkService deepLinkService = Get.find<DeepLinkService>();

  Future<void> handleStartup() async {
    await deepLinkService.onInitialized;

    final deepLinkPath = deepLinkService.pendingPath.value;
    final isLoggedIn = await homeCtrl.readLoginStatusFromStorage();

    if (isLoggedIn) {
      if (deepLinkPath != null && deepLinkPath.isNotEmpty) {
        final page = await resolveDeepLinkPage(deepLinkPath);

        deepLinkService.pendingPath.value = null;

        if (page != null) {
          Get.offAll(() => page);
          return;
        }
      }

      Get.offAll(() => MainNavigationScreen(initialTab: 'home'));
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
