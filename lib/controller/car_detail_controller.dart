import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import '../../../data/models/car.dart';

class CarDetailController extends GetxController {
  final Rxn<Car> car = Rxn<Car>();
  final String carId;

  CarDetailController(this.carId);

  @override
  void onInit() {
    super.onInit();
    _fetchCarById(carId);
  }

  Future<void> _fetchCarById(String id) async {
    try {
      final box = await Hive.openBox<Car>('cars');

      final foundCar = box.values.firstWhereOrNull((c) => c.id == id);
      if (foundCar != null) {
        car.value = foundCar;
        print('Car loaded: ${foundCar.title}');
      } else {
        print('No car found with ID: $id');
      }
    } catch (e) {
      print('Error loading car: $e');
    }
  }
}
