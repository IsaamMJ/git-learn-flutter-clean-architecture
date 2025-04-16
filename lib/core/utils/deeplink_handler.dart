import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled/data/models/car.dart';
import 'package:untitled/presentation/pages/car_detail.dart';
import 'package:collection/collection.dart';

Future<Widget?> resolveDeepLinkPage(String path) async {
  try {
    final uri = Uri.parse(path);

    if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'car') {
      final carId = uri.pathSegments[1];
      final box = Hive.isBoxOpen('cars') ? Hive.box<Car>('cars') : await Hive.openBox<Car>('cars');

      final foundCar = box.values.firstWhereOrNull((c) => c.id == carId);

      if (foundCar != null) {
        return CarDetailPage(carId: carId);
      }
    }
  } catch (e) {
    print('Error parsing path: $path\n$e');
  }

  return null;
}
