import '../../data/models/car.dart';
import '../repositories/car_repository.dart';

class AddCarUseCase {
  final CarRepository repository;

  AddCarUseCase(this.repository);

  Future<void> call(Car car) async {
    await repository.addCar(car);
  }
}

