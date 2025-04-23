import 'package:get/get.dart';
import 'package:untitled/controller/theme_controller.dart';
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
import '../../core/services/firebase_notification_service.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(ThemeController(), permanent: true);


    final firebaseNotificationService = FirebaseNotificationService();
    firebaseNotificationService.init();
    Get.put(firebaseNotificationService, permanent: true);


    final authRepository = AuthRepositoryImpl();
    final logoutUseCase = LogoutUseCase(authRepository);
    final checkLoginStatusUseCase = CheckLoginStatusUseCase(authRepository);


    final carLocalDatasource = CarLocalDatasource();
    final carRepository = CarRepositoryImpl(carLocalDatasource);
    final getAllCarsUseCase = GetAllCarsUseCase(carRepository);
    final addCarUseCase = AddCarUseCase(carRepository);
    final updateCarUseCase = UpdateCarUseCase(carRepository);
    final deleteCarUseCase = DeleteCarUseCase(carRepository);


    final hiveDebugService = Get.put(HiveDebugService(), permanent: true);


    Get.put<HomeController>(
      HomeController(
        logoutUseCase: logoutUseCase,
        getAllCarsUseCase: getAllCarsUseCase,
        addCarUseCase: addCarUseCase,
        updateCarUseCase: updateCarUseCase,
        deleteCarUseCase: deleteCarUseCase,
        checkLoginStatusUseCase: checkLoginStatusUseCase,
        hiveDebugService: hiveDebugService,
      ),
      permanent: true,
    );
  }
}
