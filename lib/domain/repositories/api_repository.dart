import '../entities/api_data_entity.dart';

abstract class ApiRepository {
  Future<List<ApiDataEntity>> fetchData();
}
