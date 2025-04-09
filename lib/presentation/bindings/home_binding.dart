import 'package:get/get.dart';
import 'package:untitled/data/datasources/local_storage_datasource.dart';
import 'package:untitled/data/repositories/auth_repository_impl.dart';
import 'package:untitled/domain/usecases/logout_usecase.dart';
import 'package:untitled/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {

    final localStorageDataSource = LocalStorageDatasource();


    final authRepository = AuthRepositoryImpl(localStorageDataSource);


    final logoutUseCase = LogoutUseCase(authRepository);


    Get.put<HomeController>(
      HomeController(logoutUseCase: logoutUseCase),
    );
  }
}
