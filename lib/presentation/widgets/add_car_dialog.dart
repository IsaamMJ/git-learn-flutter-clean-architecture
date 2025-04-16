import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../data/models/car.dart';

class AddCarDialog extends StatefulWidget {
  const AddCarDialog({super.key});

  @override
  State<AddCarDialog> createState() => _AddCarDialogState();

  static void show() {
    Get.dialog(const Dialog(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: AddCarDialog(),
      ),
    ));
  }
}

class _AddCarDialogState extends State<AddCarDialog> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final imageUrlController = TextEditingController();
  final HomeController homeCtrl = Get.find<HomeController>();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  void _addCar() {
    final title = titleController.text.trim();
    final desc = descController.text.trim();
    final imageUrl = imageUrlController.text.trim();

    if (title.isNotEmpty && desc.isNotEmpty) {
      final newCar = Car(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: desc,
        imageUrl: imageUrl.isNotEmpty
            ? imageUrl
            : 'https://www.carlogos.org/car-logos/mercedes-benz-logo.png',
      );
      homeCtrl.addCar(newCar);
      Get.back(); // close dialog
      Get.snackbar(
        "Car Added Successfully",
        "'${newCar.title}' has been added.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade700,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
    } else {
      Get.snackbar(
        "Missing Fields",
        "Please fill in all required fields",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Car Title')),
        const SizedBox(height: 10),
        TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
        const SizedBox(height: 10),
        TextField(controller: imageUrlController, decoration: const InputDecoration(labelText: 'Image URL')),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: Get.back, child: const Text('Cancel')),
            ElevatedButton(onPressed: _addCar, child: const Text('Add')),
          ],
        )
      ],
    );
  }
}
