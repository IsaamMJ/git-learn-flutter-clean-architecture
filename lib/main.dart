import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/services/firebase_notification_service.dart';
import 'core/services/deep_link_service.dart';
import 'data/models/car.dart';
import 'presentation/bindings/base_binding.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp();

  // ✅ Initialize Hive for local storage
  await Hive.initFlutter();
  Hive.registerAdapter(CarAdapter());

  // ✅ Load theme preference
  final themeBox = await Hive.openBox('settings');
  final isDark = themeBox.get('isDarkMode', defaultValue: false) as bool;
  Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);

  // ✅ Deep Link Service (GetX singleton)
  final deepLinkService = Get.put(DeepLinkService(), permanent: true);
  await deepLinkService.onInitialized;

  // ✅ Firebase Push Notification Setup
  final notificationService = Get.put(FirebaseNotificationService(), permanent: true);
  await notificationService.init();

  runApp(const MyApp());
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
      initialBinding: BaseBinding(), // ✅ Global DI bindings
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splash,
    );
  }
}
