import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'package:untitled/presentation/bindings/base_binding.dart';
import 'package:untitled/data/models/car.dart'; // ✅ Make sure this path is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Ensures binding before async calls

  await Hive.initFlutter();                  // ✅ Initialize Hive
  Hive.registerAdapter(CarAdapter());        // ✅ Register the adapter for Car model

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "XYZ Company App",

      // Theme Setup
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,

      // Dependency injection
      initialBinding: BaseBinding(),

      // Routing with GetX
      getPages: AppPages.pages,
      initialRoute: AppRoutes.login,
    );
  }
}
