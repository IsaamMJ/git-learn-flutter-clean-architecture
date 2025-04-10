import 'package:untitled/domain/repositories/car_repository.dart';


class DeleteCarUseCase {
  final CarRepository repository;
  DeleteCarUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteCar(id);
  }
}
