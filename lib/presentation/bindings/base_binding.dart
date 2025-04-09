import 'package:get/get.dart';
import 'package:untitled/controller/theme_controller.dart';


class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
  }
}
