import '../entities/api_data_entity.dart';
import '../repositories/api_repository.dart';

class FetchApiDataUseCase {
  final ApiRepository repository;

  FetchApiDataUseCase(this.repository);

  Future<List<ApiDataEntity>> call() => repository.fetchData();
}
