import 'package:dio/dio.dart';
import '../models/api_data_model.dart';

class ApiRemoteDatasource {
  final Dio _dio = Dio();

  Future<List<ApiDataModel>> fetchApiData() async {
    final response = await _dio.get('https://mocki.io/v1/09573130-7d4e-418c-9281-5be793f76218');
    final dataList = response.data['data'] as List;
    return dataList.map((e) => ApiDataModel.fromJson(e)).toList();
  }
}
