import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'presentation/bindings/base_binding.dart';
import 'data/models/car.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initLocalStorage();
  runApp(const MyApp());
}

Future<void> _initLocalStorage() async {
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(CarAdapter());
  } catch (e) {
    print('Failed to initialize local storage: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "XYZ Company App",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,

      initialBinding: BaseBinding(),

      getPages: AppPages.pages,

      initialRoute: AppRoutes.login,
    );
  }
}
