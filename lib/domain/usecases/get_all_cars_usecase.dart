import '../../data/models/car.dart';
import '../repositories/car_repository.dart';

class GetAllCarsUseCase {
  final CarRepository repository;

  GetAllCarsUseCase(this.repository);

  Future<List<Car>> call() async {
    return await repository.getAllCars();
  }
}
