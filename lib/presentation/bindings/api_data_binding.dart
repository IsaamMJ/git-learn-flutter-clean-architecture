import 'package:get/get.dart';
import '../../controller/api_data_controller.dart';

class ApiDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiDataController>(() => ApiDataController());
  }
}
