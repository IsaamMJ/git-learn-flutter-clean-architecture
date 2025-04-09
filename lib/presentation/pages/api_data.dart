// lib/presentation/pages/api_data.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/api_data_controller.dart';

class ApiDataPage extends StatelessWidget {
  const ApiDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApiDataController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          final item = controller.items[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(item.imageUrl),
              title: Text("Item ${item.id}"),
              subtitle: Text(item.description),
            ),
          );
        },
      );
    });
  }
}
