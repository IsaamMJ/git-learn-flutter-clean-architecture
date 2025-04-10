import 'package:get/get.dart';
import '../data/models/car.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/get_all_cars_usecase.dart';
import '../domain/usecases/add_car_usecase.dart';
import '../domain/usecases/update_car_usecase.dart';
import '../domain/usecases/delete_car_usecase.dart';
import 'package:untitled/debug/hive_debug_service.dart';

class HomeController extends GetxController {
  // UseCases
  final LogoutUseCase _logoutUseCase;
  final GetAllCarsUseCase _getAllCarsUseCase;
  final AddCarUseCase _addCarUseCase;
  final UpdateCarUseCase _updateCarUseCase;
  final DeleteCarUseCase _deleteCarUseCase;

  // Debug Service (Hive)
  final HiveDebugService _hiveDebugService;

  // Car list to be used in UI (observable)
  final RxList<Car> items = <Car>[].obs;

  HomeController({
    required LogoutUseCase logoutUseCase,
    required GetAllCarsUseCase getAllCarsUseCase,
    required AddCarUseCase addCarUseCase,
    required UpdateCarUseCase updateCarUseCase,
    required DeleteCarUseCase deleteCarUseCase,
    HiveDebugService? hiveDebugService, // optional injection (for testing/flexibility)
  })  : _logoutUseCase = logoutUseCase,
        _getAllCarsUseCase = getAllCarsUseCase,
        _addCarUseCase = addCarUseCase,
        _updateCarUseCase = updateCarUseCase,
        _deleteCarUseCase = deleteCarUseCase,
        _hiveDebugService = hiveDebugService ?? Get.find<HiveDebugService>();

  @override
  void onInit() {
    super.onInit();
    loadCars();
  }

  /// Load cars from Hive
  void loadCars() async {
    final carList = await _getAllCarsUseCase();
    items.assignAll(carList);
  }

  /// Add new car
  Future<void> addCar(Car car) async {
    await _addCarUseCase(car);
    items.add(car);
  }

  /// Update car by ID
  Future<void> updateCar(String id, Car updatedCar) async {
    await _updateCarUseCase(id, updatedCar);
    final index = items.indexWhere((item) => item.id == id);
    if (index != -1) {
      items[index] = updatedCar;
    }
  }

  /// Delete car by ID
  Future<void> deleteCar(String id) async {
    await _deleteCarUseCase(id);
    items.removeWhere((item) => item.id == id);
  }

  /// Logout logic
  Future<void> logout() async => await _logoutUseCase();

  /// 🔍 Print all Hive data (for debug use)
  void debugPrintHiveData() {
    _hiveDebugService.printAllCars();
  }
}
