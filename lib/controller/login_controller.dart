import 'package:get/get.dart';
import '../../core/constant/regex.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/check_login_status_usecase.dart';
import '../../routes/app_routes.dart';
import '../../domain/entities/user_entity.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;
  final CheckLoginStatusUseCase _checkStatusUseCase;

  LoginController({
    required LoginUseCase loginUseCase,
    required CheckLoginStatusUseCase checkStatusUseCase,
  })  : _loginUseCase = loginUseCase,
        _checkStatusUseCase = checkStatusUseCase;

  final email = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;

  Future<UserEntity?> login() async {
    isLoading.value = true;
    try {
      UserEntity? user = await _loginUseCase(email.value, password.value);
      if (user != null) {
        Get.offAllNamed(AppRoutes.main, arguments: 'home');
      } else {
        Get.snackbar("Login Failed", "Invalid email or password.");
      }
    } catch (e) {
      print('Login error: $e');
      Get.snackbar("Login Failed", "An unexpected error occurred.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> isLoggedIn() async => await _checkStatusUseCase();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter email";
    } else if (!AppRegex.emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter password';
    }
    if (!AppRegex.passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters, include 1 letter and 1 number';
    }
    return null;
  }
}
