import 'package:hive/hive.dart';
import '../data/models/car.dart';

class HiveDebugService {
  Future<void> printAllCars() async {
    final box = await Hive.openBox<Car>('cars');
    print(" HIVE BOX: [cars]");

    if (box.isEmpty) {
      print(" No cars found.");
      return;
    }

    for (var key in box.keys) {
      final car = box.get(key);
      print(" [$key] => ${car?.title} | ${car?.description} | ${car?.imageUrl}");
    }
  }
}
