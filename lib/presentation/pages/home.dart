import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../widgets/car_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Obx(() {
      final items = controller.items;

      if (items.isEmpty) {
        return const Center(child: Text('No cars available'));
      }

      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final car = items[index];
          return CarCard(
            car: car,
            index: index,
            onDelete: () {
              Get.defaultDialog(
                title: "Confirm Deletion",
                middleText: "Are you sure you want to delete this car?",
                textCancel: "Cancel",
                textConfirm: "Confirm",
                onCancel: Get.back,
                onConfirm: () async {
                  await controller.deleteCar(car.id);
                  Get.back();
                },
              );
            },
            onEdit: (newTitle, newDesc) async {
              final updatedCar = car.copyWith(
                title: newTitle,
                description: newDesc,
              );
              await controller.updateCar(car.id, updatedCar);
            },

          );
        },
      );
    });
  }
}
