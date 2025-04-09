import '../../domain/repositories/auth_repository.dart';
import '../datasources/local_storage_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalStorageDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<void> login(String email, String password) async {

    await _datasource.setLoggedIn(true);
  }

  @override
  Future<void> logout() async {
    await _datasource.setLoggedIn(false);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _datasource.isLoggedIn();
  }
}
