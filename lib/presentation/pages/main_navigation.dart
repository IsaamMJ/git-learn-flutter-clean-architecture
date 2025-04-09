import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../controller/api_data_controller.dart';
import '../../controller/theme_controller.dart';
import 'api_data.dart';
import 'home.dart';
import '../../routes/app_routes.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeCtrl = Get.find<ThemeController>();
    final homeCtrl = Get.find<HomeController>();
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text("XYZ Company"),
          automaticallyImplyLeading: false,
          actions: [
            //  Theme toggle
            Obx(() => IconButton(
              icon: Icon(
                themeCtrl.isDark.value ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: () => themeCtrl.toggleTheme(),
            )),

            //  Logout
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await homeCtrl.logout();
                Get.offAllNamed(AppRoutes.login);
              },
            ),
          ],
        ),

        //
        body: Obx(() => _screens[selectedIndex.value]),

        //
        bottomNavigationBar: Obx(() => BottomNavigationBar(
          currentIndex: selectedIndex.value,  // Use reactive value
          onTap: (index) {
            selectedIndex.value = index;  // Set the selected index reactively
          },
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
        )),
      ),
    );
  }
}
