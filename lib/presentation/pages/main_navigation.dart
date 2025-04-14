import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../controller/api_data_controller.dart';
import '../../controller/theme_controller.dart';
import 'api_data.dart';
import 'home.dart';
import '../../routes/app_routes.dart';
import '../../data/models/car.dart';

class MainNavigationScreen extends StatefulWidget {
  final String initialTab;
  final Widget? child;
  final bool? showNavBar;

  const MainNavigationScreen({
    super.key,
    this.initialTab = 'home',
    this.child,
    this.showNavBar = true,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final ThemeController themeCtrl = Get.find<ThemeController>();
  final HomeController homeCtrl = Get.find<HomeController>();
  final ApiDataController apiCtrl = Get.put(ApiDataController(), permanent: true);

  final RxInt selectedIndex = 0.obs;

  final List<Widget> _screens = const [
    HomeScreen(),
    ApiDataPage(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex.value = (widget.initialTab == 'api-data') ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    final bool showNavBar = widget.showNavBar ?? true;
    return Scaffold(
      appBar: AppBar(
        title: const Text("XYZ Company"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report),
            onPressed: homeCtrl.debugPrintHiveData,
            tooltip: 'Print Hive Data',
          ),
          IconButton(
            icon: Icon(
              themeCtrl.isDark.value ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: themeCtrl.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await homeCtrl.logout();

              final status = await homeCtrl.readLoginStatusFromStorage();
              Get.offAllNamed(AppRoutes.login);
            },
          ),

        ],
      ),

      body: widget.child ?? Obx(() => _screens[selectedIndex.value]),

      bottomNavigationBar: showNavBar
          ? Obx(() => BottomNavigationBar(
        currentIndex: selectedIndex.value,
        onTap: (index) => selectedIndex.value = index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud_download), label: 'API Data'),
        ],
      ))
          : null,

      floatingActionButton: showNavBar && selectedIndex.value == 0
          ? _buildFAB()
          : null,
    );
  }

  Widget _buildFAB() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final imageUrlController = TextEditingController();

    return FloatingActionButton(
      onPressed: () {
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
    );
  }
}
