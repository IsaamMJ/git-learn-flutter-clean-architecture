import 'package:get/get.dart';
import 'package:untitled/controller/theme_controller.dart';
import 'package:untitled/core/services/deep_link_service.dart';
import 'package:untitled/core/services/pending_navigation_service.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
    Get.put(DeepLinkService(), permanent: true);
    Get.put(PendingNavigationService(), permanent: true);
  }
}
