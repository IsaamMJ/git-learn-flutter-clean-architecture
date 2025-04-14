import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import '../../../data/models/car.dart';

class CarDetailController extends GetxController {
  final Rxn<Car> car = Rxn<Car>();

  @override
  void onInit() {
    super.onInit();
    _loadCarFromRoute();
  }

  void _loadCarFromRoute() async {
    final carId = Get.parameters['id'];
    if (carId != null && carId.trim().isNotEmpty) {
      await _fetchCarById(carId);
    } else {
      print(' No car ID provided');
    }
  }

  Future<void> _fetchCarById(String id) async {
    try {
      final box = await Hive.openBox<Car>('cars');

      final foundCar = box.values.firstWhereOrNull((c) => c.id == id);
      if (foundCar != null) {
        car.value = foundCar;
        print('[CarDetail] Car loaded: ${foundCar.title}');
      } else {
        print(' No car found with ID: $id');
      }
    } catch (e) {
      print(' Error loading car: $e');
    }
  }
}
