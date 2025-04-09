import '../../domain/entities/api_data_entity.dart';
import '../../domain/repositories/api_repository.dart';
import '../datasources/api_remote_datasource.dart';

class ApiRepositoryImpl implements ApiRepository {
  final ApiRemoteDatasource remoteDatasource;

  ApiRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<ApiDataEntity>> fetchData() {
    return remoteDatasource.fetchApiData();
  }
}
