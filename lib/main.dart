import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'package:untitled/presentation/bindings/base_binding.dart';

void main() {
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


      initialBinding: BaseBinding(),

      // GetX Routing
      getPages: AppPages.pages,
      initialRoute: AppRoutes.login,
    );
  }
}
