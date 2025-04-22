import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/services/firebase_notification_service.dart';
import 'presentation/bindings/base_binding.dart';
import 'data/models/car.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'core/services/deep_link_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(CarAdapter());

  final themeBox = await Hive.openBox('settings');
  final isDark = themeBox.get('isDarkMode', defaultValue: false) as bool;
  Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);

  final deepLinkService = Get.put(DeepLinkService(), permanent: true);
  await deepLinkService.onInitialized;

  // 🔥 Initialize push notifications
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
      initialBinding: BaseBinding(),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splash,
    );
  }
}
