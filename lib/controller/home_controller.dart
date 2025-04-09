import 'package:get/get.dart';
import '../data/models/car.dart';
import '../domain/usecases/logout_usecase.dart';

class HomeController extends GetxController {
  final LogoutUseCase _logoutUseCase;


  final RxList<Car> items = <Car>[
    Car(
        id: "1",
        imageUrl: "https://1000logos.net/wp-content/uploads/2018/02/BMW-Logo.png",
        title: "BMW",
        description: "Sheer Driving Pleasure"),
    Car(
        id: "2",
        imageUrl: "https://www.carlogos.org/logo/Mercedes-Benz-logo-2011-1920x1080.png",
        title: "Benz",
        description: "Engineered for Excellence"),
    Car(
        id: "3",
        imageUrl: "https://www.carlogos.org/logo/Audi-logo-2009-1920x1080.png",
        title: "Audi",
        description: "Unleash the Power of Progress"),
    Car(
        id: "4",
        imageUrl: "https://1000logos.net/wp-content/uploads/2018/02/BMW-Logo.png",
        title: "BMW",
        description: "Sheer Driving Pleasure"),
    Car(
        id: "5",
        imageUrl: "https://www.carlogos.org/logo/Mercedes-Benz-logo-2011-1920x1080.png",
        title: "Benz",
        description: "Engineered for Excellence"),
  ].obs;


  HomeController({required LogoutUseCase logoutUseCase})
      : _logoutUseCase = logoutUseCase;

  /// Update a car
  void updateItem(String id, Car updatedCar) {
    final index = items.indexWhere((item) => item.id == id);
    if (index != -1) {
      items[index] = updatedCar;
    }
  }

  /// Delete a car
  void deleteItem(String id) {
    items.removeWhere((item) => item.id == id);
  }

  /// Executes the logout usecase
  Future<void> logout() async => await _logoutUseCase();
}
