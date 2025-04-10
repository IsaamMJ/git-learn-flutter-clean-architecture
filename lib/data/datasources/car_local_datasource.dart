import 'package:hive/hive.dart';
import '../models/car.dart';

class CarLocalDatasource {
  static const String _boxName = 'cars';

  Future<Box<Car>> _openBox() async {
    return await Hive.openBox<Car>(_boxName);
  }

  Future<List<Car>> getAllCars() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> addCar(Car car) async {
    final box = await _openBox();
    await box.put(car.id, car);
  }

  Future<void> updateCar(String id, Car updatedCar) async {
    final box = await _openBox();
    await box.put(id, updatedCar);
  }

  Future<void> deleteCar(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }
}
