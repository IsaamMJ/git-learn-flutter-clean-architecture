import '../../data/datasources/car_local_datasource.dart';
import '../../data/models/car.dart';
import '../../domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final CarLocalDatasource _localDatasource;

  CarRepositoryImpl(this._localDatasource);

  @override
  Future<List<Car>> getAllCars() {
    return _localDatasource.getAllCars();
  }

  @override
  Future<void> addCar(Car car) {
    return _localDatasource.addCar(car);
  }

  @override
  Future<void> updateCar(String id, Car updatedCar) {
    return _localDatasource.updateCar(id, updatedCar);
  }

  @override
  Future<void> deleteCar(String id) {
    return _localDatasource.deleteCar(id);
  }
}
