import '../repositories/auth_repository.dart';

class CheckLoginStatusUseCase {
  final AuthRepository _repository;

  CheckLoginStatusUseCase(this._repository);


  Future<bool> call() async {
    return await _repository.isLoggedIn();
  }
}
