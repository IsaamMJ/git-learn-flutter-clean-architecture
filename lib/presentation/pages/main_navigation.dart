import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../controller/api_data_controller.dart';
import '../../controller/theme_controller.dart';
import 'api_data.dart';
import 'home.dart';
import '../../routes/app_routes.dart';
import '../../data/models/car.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeCtrl = Get.find<ThemeController>();
    final HomeController homeCtrl = Get.find<HomeController>();
    final ApiDataController apiCtrl = Get.put(ApiDataController(), permanent: true);

    final List<Widget> _screens = const [
      HomeScreen(),
      ApiDataPage(),
    ];

    RxInt selectedIndex = 0.obs;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) SystemNavigator.pop();
      },
      child: Obx(() => Scaffold(
        appBar: AppBar(
          title: const Text("XYZ Company"),
          automaticallyImplyLeading: false,
          actions: [

            IconButton(
              icon: const Icon(Icons.bug_report),
              onPressed: () => homeCtrl.debugPrintHiveData(),
              tooltip: 'Print Hive Data',
            ),

            // Theme toggle
            IconButton(
              icon: Icon(
                themeCtrl.isDark.value ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: () => themeCtrl.toggleTheme(),
            ),

            // Logout
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await homeCtrl.logout();
                Get.offAllNamed(AppRoutes.login);
              },
            ),
          ],
        ),

        body: _screens[selectedIndex.value],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex.value,
          onTap: (index) => selectedIndex.value = index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_download),
              label: 'API Data',
            ),
          ],
        ),

        floatingActionButton: selectedIndex.value == 0
            ? FloatingActionButton(
          onPressed: () {
            final titleController = TextEditingController();
            final descController = TextEditingController();
            final imageUrlController = TextEditingController();

            Get.defaultDialog(
              title: "Add Car",
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Car Title'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: imageUrlController,
                    decoration: const InputDecoration(labelText: 'Image URL'),
                  ),
                ],
              ),
              textCancel: "Cancel",
              textConfirm: "Add",
              onCancel: Get.back,
              onConfirm: () {
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
                  Get.back();
                } else {
                  Get.snackbar("Missing Fields", "Please fill in all required fields");
                }
              },
            );
          },
          tooltip: 'Add Car',
          child: const Icon(Icons.add),
        )
            : null,
      )),
    );
  }
}
