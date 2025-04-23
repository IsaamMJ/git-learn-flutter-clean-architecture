import 'package:get/get.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    final authRepository = AuthRepositoryImpl();
    final registerUseCase = RegisterUseCase(authRepository);

    Get.put(RegisterController(registerUseCase: registerUseCase));
  }
}

