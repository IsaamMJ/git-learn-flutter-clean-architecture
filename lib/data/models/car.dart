class Car {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Car({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  Car copyWith({
    String? title,
    String? description,

  }) {
    return Car(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
