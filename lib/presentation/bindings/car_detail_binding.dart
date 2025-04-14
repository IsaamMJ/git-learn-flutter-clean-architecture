import 'package:get/get.dart';
import 'package:untitled/controller/car_detail_controller.dart';

class CarDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarDetailController>(() => CarDetailController());
  }
}
