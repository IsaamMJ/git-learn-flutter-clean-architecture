import 'package:get/get.dart';
import '../data/models/car.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/get_all_cars_usecase.dart';
import '../domain/usecases/add_car_usecase.dart';
import '../domain/usecases/update_car_usecase.dart';
import '../domain/usecases/delete_car_usecase.dart';
import '../domain/usecases/check_login_status_usecase.dart';
import 'package:untitled/debug/hive_debug_service.dart';

class HomeController extends GetxController {
  final LogoutUseCase _logoutUseCase;
  final GetAllCarsUseCase _getAllCarsUseCase;
  final AddCarUseCase _addCarUseCase;
  final UpdateCarUseCase _updateCarUseCase;
  final DeleteCarUseCase _deleteCarUseCase;
  final CheckLoginStatusUseCase _checkLoginStatusUseCase;
  final HiveDebugService _hiveDebugService;

  final RxList<Car> items = <Car>[].obs;
  final RxBool isLoggedIn = false.obs;

  HomeController({
    required LogoutUseCase logoutUseCase,
    required GetAllCarsUseCase getAllCarsUseCase,
    required AddCarUseCase addCarUseCase,
    required UpdateCarUseCase updateCarUseCase,
    required DeleteCarUseCase deleteCarUseCase,
    required CheckLoginStatusUseCase checkLoginStatusUseCase,
    HiveDebugService? hiveDebugService,
  })  : _logoutUseCase = logoutUseCase,
        _getAllCarsUseCase = getAllCarsUseCase,
        _addCarUseCase = addCarUseCase,
        _updateCarUseCase = updateCarUseCase,
        _deleteCarUseCase = deleteCarUseCase,
        _checkLoginStatusUseCase = checkLoginStatusUseCase,
        _hiveDebugService = hiveDebugService ?? Get.find<HiveDebugService>();

  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
    loadCars();
  }

  void _checkAuthStatus() async {
    final result = await _checkLoginStatusUseCase();
    isLoggedIn.value = result;

    // 🚫 No deep link navigation here — handled by SplashScreen
  }

  Future<bool> readLoginStatusFromStorage() async {
    final result = await _checkLoginStatusUseCase();
    return result;
  }

  Future<bool> checkIfLoggedIn() async {
    final result = await _checkLoginStatusUseCase();
    isLoggedIn.value = result;
    return result;
  }

  Future<void> logout() async {
    await _logoutUseCase();
    isLoggedIn.value = false;
    final stored = await readLoginStatusFromStorage();
  }

  Future<void> addCar(Car car) async {
    await _addCarUseCase(car);
    items.add(car);
  }

  Future<void> updateCar(String id, Car updatedCar) async {
    await _updateCarUseCase(id, updatedCar);
    final index = items.indexWhere((item) => item.id == id);
    if (index != -1) {
      items[index] = updatedCar;
    }
  }

  Future<void> deleteCar(String id) async {
    await _deleteCarUseCase(id);
    items.removeWhere((item) => item.id == id);
  }

  void loadCars() async {
    final carList = await _getAllCarsUseCase();
    items.assignAll(carList);
  }

  void debugPrintHiveData() {
    _hiveDebugService.printAllCars();
  }
}
