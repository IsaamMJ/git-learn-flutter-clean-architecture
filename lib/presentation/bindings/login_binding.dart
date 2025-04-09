import 'package:get/get.dart';
import '../../data/datasources/local_storage_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/check_login_status_usecase.dart';
import 'package:untitled/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {

    final localStorageDataSource = LocalStorageDatasource();

    final authRepository = AuthRepositoryImpl(localStorageDataSource);

    final loginUseCase = LoginUseCase(authRepository);
    final checkLoginStatusUseCase = CheckLoginStatusUseCase(authRepository);

    Get.put<LoginController>(
      LoginController(
        loginUseCase: loginUseCase,
        checkStatusUseCase: checkLoginStatusUseCase,
      ),
    );
  }
}
