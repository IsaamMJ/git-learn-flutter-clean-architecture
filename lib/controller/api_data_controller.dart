import 'package:get/get.dart';
import '../data/datasources/api_remote_datasource.dart';
import '../data/repositories/api_repository_impl.dart';
import '../domain/entities/api_data_entity.dart';
import '../domain/usecases/fetch_api_data_usecase.dart';

class ApiDataController extends GetxController {
  final items = <ApiDataEntity>[].obs;
  final isLoading = true.obs;

  late final FetchApiDataUseCase _useCase;

  @override
  void onInit() {
    _useCase = FetchApiDataUseCase(ApiRepositoryImpl(ApiRemoteDatasource()));
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      final result = await _useCase();
      items.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch data");
    } finally {
      isLoading(false);
    }
  }
}
