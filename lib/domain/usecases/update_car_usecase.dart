import 'package:untitled/domain/repositories/car_repository.dart';
import '../../data/models/car.dart';


class UpdateCarUseCase {
  final CarRepository repository;
  UpdateCarUseCase(this.repository);

  Future<void> call(String id, Car updatedCar) {
    return repository.updateCar(id, updatedCar);
  }
}
