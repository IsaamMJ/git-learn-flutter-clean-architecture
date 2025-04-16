import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../controller/api_data_controller.dart';
import '../../controller/theme_controller.dart';
import '../../routes/app_routes.dart';
import 'api_data.dart';
import 'home.dart';
import 'package:untitled/presentation/widgets/add_car_dialog.dart';

class MainNavigationScreen extends StatefulWidget {
  final String initialTab;
  final bool? showNavBar;

  MainNavigationScreen({
    Key? key,
    String? initialTab,
    this.showNavBar = true,
  })  : initialTab = initialTab ?? Get.arguments ?? 'home',
        super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final ThemeController themeCtrl = Get.find<ThemeController>();
  final HomeController homeCtrl = Get.find<HomeController>();
  final ApiDataController apiCtrl = Get.put(ApiDataController(), permanent: true);
  final RxInt selectedIndex = 0.obs;

  final List<Widget> _screens = [
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
            icon: Icon(themeCtrl.isDark.value ? Icons.dark_mode : Icons.light_mode),
            onPressed: themeCtrl.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await homeCtrl.logout();
              await homeCtrl.readLoginStatusFromStorage();
              Get.offAllNamed(AppRoutes.login);
            },
          ),
        ],
      ),
      body: Obx(() => _screens[selectedIndex.value]),
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
      floatingActionButton: Obx(() {
        return (showNavBar && selectedIndex.value == 0)
            ? FloatingActionButton(
          onPressed: () {
            AddCarDialog.show();
          },
          tooltip: 'Add Car',
          child: const Icon(Icons.add),
        )
            : const SizedBox.shrink();
      }),
    );
  }
}
