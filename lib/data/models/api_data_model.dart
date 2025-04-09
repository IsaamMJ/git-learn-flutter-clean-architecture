import '../../domain/entities/api_data_entity.dart';

class ApiDataModel extends ApiDataEntity {
  ApiDataModel({
    required int id,
    required String imageUrl,
    required String description,
  }) : super(id: id, imageUrl: imageUrl, description: description);

  factory ApiDataModel.fromJson(Map<String, dynamic> json) {
    return ApiDataModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      description: json['description'],
    );
  }
}
