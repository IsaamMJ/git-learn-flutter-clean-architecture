import 'package:get/get.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../core/constant/regex.dart';

class RegisterController extends GetxController {
  final RegisterUseCase _registerUseCase;

  RegisterController({required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase;

  final email = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;

  Future<UserEntity?> register() async {
    isLoading.value = true;
    try {
      final user = await _registerUseCase(email.value, password.value);
      if (user == null) {
        Get.snackbar("Register Failed", "Could not create user.");
      }
      return user;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

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
