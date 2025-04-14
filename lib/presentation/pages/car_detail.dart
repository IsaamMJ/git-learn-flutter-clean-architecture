import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/car_detail_controller.dart';
import 'package:untitled/routes/app_routes.dart';

class CarDetailPage extends GetView<CarDetailController> {
  const CarDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? null
            : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed(AppRoutes.main, arguments: 'home'),
        ),
        title: const Text('Detail Page'),
        centerTitle: true,
      ),
      body: Obx(() {
        final car = controller.car.value;

        if (car == null) {
          return const Center(child: Text("Car not found or still loading..."));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  car.imageUrl,
                  height: 240,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Icon(Icons.broken_image, size: 80, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        car.title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        car.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
