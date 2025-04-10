import 'package:hive/hive.dart';

part 'car.g.dart';

@HiveType(typeId: 0)
class Car {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  Car({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  Car copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? description,
  }) {
    return Car(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
