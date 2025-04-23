import 'package:get/get.dart';
import 'package:untitled/controller/home_controller.dart';
import 'package:untitled/data/datasources/car_local_datasource.dart';
import 'package:untitled/data/repositories/auth_repository_impl.dart';
import 'package:untitled/data/repositories/car_repository_impl.dart';
import 'package:untitled/domain/usecases/logout_usecase.dart';
import 'package:untitled/domain/usecases/get_all_cars_usecase.dart';
import 'package:untitled/domain/usecases/add_car_usecase.dart';
import 'package:untitled/domain/usecases/update_car_usecase.dart';
import 'package:untitled/domain/usecases/delete_car_usecase.dart';
import 'package:untitled/domain/usecases/check_login_status_usecase.dart';
import 'package:untitled/debug/hive_debug_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HiveDebugService());


    final authRepository = AuthRepositoryImpl();

    final logoutUseCase = LogoutUseCase(authRepository);
    final checkLoginStatusUseCase = CheckLoginStatusUseCase(authRepository);

    final carLocalDatasource = CarLocalDatasource();
    final carRepository = CarRepositoryImpl(carLocalDatasource);

    final getAllCarsUseCase = GetAllCarsUseCase(carRepository);
    final addCarUseCase = AddCarUseCase(carRepository);
    final updateCarUseCase = UpdateCarUseCase(carRepository);
    final deleteCarUseCase = DeleteCarUseCase(carRepository);

    Get.put<HomeController>(
      HomeController(
        logoutUseCase: logoutUseCase,
        getAllCarsUseCase: getAllCarsUseCase,
        addCarUseCase: addCarUseCase,
        updateCarUseCase: updateCarUseCase,
        deleteCarUseCase: deleteCarUseCase,
        checkLoginStatusUseCase: checkLoginStatusUseCase,
      ),
    );
  }
}
