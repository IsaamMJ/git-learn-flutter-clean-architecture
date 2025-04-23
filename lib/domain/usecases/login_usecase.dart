import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<UserEntity?> call(String email, String password) async {
    return await _repository.login(email, password);
  }
}
