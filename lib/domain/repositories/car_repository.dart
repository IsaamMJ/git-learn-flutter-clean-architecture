import '../../data/models/car.dart';

abstract class CarRepository {
  Future<List<Car>> getAllCars();
  Future<void> addCar(Car car);
  Future<void> updateCar(String id, Car updatedCar);
  Future<void> deleteCar(String id);
}
