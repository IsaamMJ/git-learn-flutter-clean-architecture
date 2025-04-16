import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeController extends GetxController {
  final isDark = false.obs;

  static const String _themeBoxName = 'settings';
  static const String _themeKey = 'isDarkMode';

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromStorage();
  }

  void _loadThemeFromStorage() async {
    final box = await Hive.openBox(_themeBoxName);
    final savedTheme = box.get(_themeKey, defaultValue: false) as bool;
    isDark.value = savedTheme;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() async {
    isDark.value = !isDark.value;
    final box = await Hive.openBox(_themeBoxName);
    await box.put(_themeKey, isDark.value);
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
